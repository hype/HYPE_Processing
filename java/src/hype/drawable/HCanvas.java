package hype.drawable;

import hype.util.H;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PGraphics;

public class HCanvas extends HDrawable {
	protected PGraphics _buffer;
	protected float _filterParam;
	protected int _filterKind, _blendMode;
	protected boolean _autoClear,_hasFade,_hasFilter,_hasFilterParam,_hasBlend;
	
	public HCanvas() {
		this(H.app().width, H.app().height);
	}
	
	public HCanvas(float w, float h) {
		size(w,h);
	}
	
	public HCanvas filter(int kind) {
		_hasFilter = true;
		_hasFilterParam = false;
		_filterKind = kind;
		return this;
	}
	
	public HCanvas filter(int kind, int param) {
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
	
	public HCanvas fade() {
		_hasFade = true;
		return this;
	}
	
	public HCanvas fade(int bgAlpha) {
		_hasFade = true;
		background(_fill, bgAlpha);
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
	
	@SuppressWarnings("static-access")
	@Override
	public HCanvas size(float w, float h) {
		PApplet app = H.app();
		
		int tmpw = app.round(w);
		int tmph = app.round(h);
		
		_buffer = app.createGraphics(tmpw, tmph);
		
		_width = tmpw;
		_height = tmph;
		
		return this;
	}
	
	@Override
	public HCanvas size(float s) {
		return size(s,s);
	}
	
	@Override
	public HCanvas width(float w) {
		return size(w, _height);
	}
	
	@Override
	public HCanvas height(float h) {
		return size(_width, h);
	}
	
	@Override
	public HCanvas createCopy() {
		HCanvas copy = new HCanvas(_width,_height);
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	@Override
	public void paintAll(PGraphics g, float currAlphaPerc) {
		if(_alpha<=0 || _width<=0 || _height<=0) return;
		g.pushMatrix();
			// Rotate and translate
			g.translate(_x,_y);
			g.rotate(_rotationRad);
			
			// Compute current alpha
			currAlphaPerc *= _alpha;
			
			// Initialize the buffer
			_buffer.beginDraw();
			
			// Prepare the buffer for this frame
			if(_autoClear) {
				_buffer.clear();
			} else {
				if(_hasFilter) {
					if(_hasFilterParam) _buffer.filter(_filterKind,_filterParam);
					else _buffer.filter(_filterKind);
				}
				if(_hasFade) {
					applyStyle(_buffer, currAlphaPerc);
					_buffer.rect(0,0, _buffer.width,_buffer.height);
				}
				if(_hasBlend) {
					_buffer.blend(
						0,0, _buffer.width,_buffer.height,
						0,0, _buffer.width,_buffer.height, _blendMode);
				}
			}
			
			// Draw children
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(_buffer,currAlphaPerc);
				child = child.next();
			}
			
			// Finalize the buffer
			_buffer.endDraw();
			
			// Draw the buffer
			g.image(_buffer,0,0);
		g.popMatrix();
	}
	
	@Override
	public void draw(
		PGraphics g, float drawX, float drawY, float currAlphaPerc) {}
}
