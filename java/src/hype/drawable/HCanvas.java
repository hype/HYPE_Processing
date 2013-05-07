package hype.drawable;

import hype.util.H;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PGraphics;

public class HCanvas extends HDrawable {
	protected PGraphics _graphics;
	protected String _renderer;
	protected float _filterParam;
	protected int _filterKind, _blendMode, _fadeAmt;
	protected boolean _autoClear,_hasFade,_hasFilter,_hasFilterParam,_hasBlend;
	
	public HCanvas() {
		this(H.app().width, H.app().height);
	}
	
	public HCanvas(String bufferRenderer) {
		this(H.app().width, H.app().height, bufferRenderer);
	}
	
	public HCanvas(float w, float h) {
		this(w, h, PConstants.JAVA2D);
	}
	
	public HCanvas(float w, float h, String bufferRenderer) {
		_renderer = bufferRenderer;
		size(w,h);
	}
	
	@Override
	public HCanvas createCopy() {
		HCanvas copy = new HCanvas(_width,_height,_renderer);
		
		copy.autoClear(_autoClear).hasFade(_hasFade);
		if(_hasFilter) copy.filter(_filterKind, _filterParam);
		if(_hasBlend) copy.blend(_blendMode);
		
		copy.copyPropertiesFrom(this);
		return copy;
	}

	@SuppressWarnings("static-access")
	protected void updateBuffer() {
		PApplet app = H.app();
		
		int w = app.round(_width);
		int h = app.round(_height);
		
		_graphics = app.createGraphics(w, h, _renderer);
		_graphics.loadPixels();
		_width = w;
		_height = h;
	}
	
	public HCanvas renderer(String s) {
		_renderer = s;
		updateBuffer();
		return this;
	}
	
	public String renderer() {
		return _renderer;
	}
	
	public boolean usesZ() {
		return _renderer.equals(PConstants.P3D) ||
			_renderer.equals(PConstants.OPENGL);
	}
	
	public PGraphics graphics() {
		return _graphics;
	}
	
	public HCanvas filter(int kind) {
		_hasFilter = true;
		_hasFilterParam = false;
		_filterKind = kind;
		return this;
	}
	
	public HCanvas filter(int kind, float param) {
		_hasFilter = true;
		_hasFilterParam = true;
		_filterKind = kind;
		_filterParam = param;
		return this;
	}
	
	public HCanvas noFilter() {
		_hasFilter = false;
		return this;
	}
	
	public boolean hasFilter() {
		return _hasFilter;
	}
	
	public HCanvas filterKind(int i) {
		_filterKind = i;
		return this;
	}
	
	public int filterKind() {
		return _filterKind;
	}
	
	public HCanvas filterParam(float f) {
		_filterParam = f;
		return this;
	}
	
	public float filterParam() {
		return _filterParam;
	}
	
	public HCanvas blend() {
		return blend(PConstants.BLEND);
	}
	
	public HCanvas blend(int mode) {
		_hasBlend = true;
		_blendMode = mode;
		return this;
	}
	
	public HCanvas noBlend() {
		_hasBlend = false;
		return this;
	}
	
	public HCanvas hasBlend(boolean b) {
		return (b)? blend() : noBlend();
	}
	
	public boolean hasBlend() {
		return _hasBlend;
	}
	
	public HCanvas blendMode(int i) {
		_blendMode = i;
		return this;
	}
	
	public int blendMode() {
		return _blendMode;
	}
	
	public HCanvas fade(int fadeAmt) {
		_hasFade = true;
		_fadeAmt = fadeAmt;
		return this;
	}
	
	public HCanvas noFade() {
		_hasFade = false;
		return this;
	}
	
	public HCanvas hasFade(boolean b) {
		_hasFade = b;
		return this;
	}
	
	public boolean hasFade() {
		return _hasFade;
	}
	
	public HCanvas autoClear(boolean b) {
		_autoClear = b;
		return this;
	}
	
	public boolean autoClear() {
		return _autoClear;
	}
	
	public HCanvas background(int clr) {
		return (HCanvas) fill(clr);
	}
	
	public HCanvas background(int clr, int alpha) {
		return (HCanvas) fill(clr, alpha);
	}
	
	public HCanvas background(int r, int g, int b) {
		return (HCanvas) fill(r, g, b);
	}
	
	public HCanvas background(int r, int g, int b, int a) {
		return (HCanvas) fill(r, g, b, a);
	}
	
	public int background() {
		return _fill;
	}
	
	public HCanvas noBackground() {
		return (HCanvas) noFill();
	}
	
	@Override
	public HCanvas size(float w, float h) {
		super.width(w);
		super.height(h);
		updateBuffer();
		return this;
	}
	
	@Override
	public HCanvas width(float w) {
		super.width(w);
		updateBuffer();
		return this;
	}
	
	@Override
	public HCanvas height(float h) {
		super.height(h);
		updateBuffer();
		return this;
	}
	
	@Override
	public void paintAll(PGraphics g, boolean usesZ, float currAlphaPerc) {
		if(_alpha<=0 || _width==0 || _height==0) return;
		g.pushMatrix();
			// Rotate and translate
			if(usesZ) g.translate(_x,_y,_z);
			else g.translate(_x,_y);
			g.rotate(_rotationRad);
			
			// Compute current alpha
			currAlphaPerc *= _alpha;
			
			// Initialize the buffer
			_graphics.beginDraw();
			
			// Prepare the buffer for this frame
			if(_autoClear) {
				_graphics.clear();
			} else {
				if(_hasFilter) {
					if(_hasFilterParam) _graphics.filter(_filterKind,_filterParam);
					else _graphics.filter(_filterKind);
				}
				if(_hasFade) {
					int[] pix = _graphics.pixels;
					for(int i=0; i<pix.length; ++i) {
						int clr = pix[i];
						int a = clr >>> 24;
						if(a == 0) continue;
						a -= _fadeAmt;
						if(a < 0) a = 0;
						pix[i] = clr & 0xFFFFFF | (a << 24);
					}
					_graphics.updatePixels();
				}
				if(_hasBlend) {
					_graphics.blend(
						0,0, _graphics.width,_graphics.height,
						0,0, _graphics.width,_graphics.height, _blendMode);
				}
			}
			
			// Draw children
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(_graphics, usesZ(),currAlphaPerc);
				child = child.next();
			}
			
			// Finalize the buffer
			_graphics.endDraw();
			
			// Draw the buffer
			g.image(_graphics,0,0);
		g.popMatrix();
	}
	
	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float currAlphaPerc) {}
}
