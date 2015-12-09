package hype;

import processing.core.PConstants;
import processing.core.PGraphics;
import processing.opengl.PShader;
import java.util.ArrayList;

public class HCanvas extends HDrawable {
	private PGraphics graphics;
	private String renderer;
	private float filterParam;
	private int filterKind, blendMode, fadeAmt;
	private boolean autoClear, hasFade, hasFilter, hasFilterParam, hasBlend, hasShader;

	private ArrayList<PShader> shader;

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
		renderer = bufferRenderer;
		size(w,h);
	}

	@Override
	public HCanvas createCopy() {
		HCanvas copy = new HCanvas(width, height, renderer);

		copy.autoClear(autoClear).hasFade(hasFade);
		if(hasFilter) copy.filter(filterKind, filterParam);
		if(hasBlend) copy.blend(blendMode);

		copy.copyPropertiesFrom(this);
		return copy;
	}

	protected void updateBuffer() {
		int w = Math.round(width);
		int h = Math.round(height);

		graphics = H.app().createGraphics(w, h, renderer);
		graphics.beginDraw();
		graphics.loadPixels();
			graphics.background(H.CLEAR);
		graphics.endDraw();

		width = w;
		height = h;
	}

	public HCanvas renderer(String s) {
		renderer = s;
		updateBuffer();
		return this;
	}

	public String renderer() {
		return renderer;
	}

	public boolean usesZ() {
		return renderer.equals(PConstants.P3D) ||
			renderer.equals(PConstants.OPENGL);
	}

	public PGraphics graphics() {
		return graphics;
	}

	public HCanvas shader(PShader s) {
		if (!hasShader) {
			hasShader = true;
			shader = new ArrayList<PShader>();
		}
		shader.add(s);
		return this;
	}

	public HCanvas filter(int kind) {
		hasFilter = true;
		hasFilterParam = false;
		filterKind = kind;
		return this;
	}

	public HCanvas filter(int kind, float param) {
		hasFilter = true;
		hasFilterParam = true;
		filterKind = kind;
		filterParam = param;
		return this;
	}

	public HCanvas noFilter() {
		hasFilter = false;
		return this;
	}

	public boolean hasFilter() {
		return hasFilter;
	}

	public HCanvas filterKind(int i) {
		filterKind = i;
		return this;
	}

	public int filterKind() {
		return filterKind;
	}

	public HCanvas filterParam(float f) {
		filterParam = f;
		return this;
	}

	public float filterParam() {
		return filterParam;
	}

	public HCanvas blend() {
		return blend(PConstants.BLEND);
	}

	public HCanvas blend(int mode) {
		hasBlend = true;
		blendMode = mode;
		return this;
	}

	public HCanvas noBlend() {
		hasBlend = false;
		return this;
	}

	public HCanvas hasBlend(boolean b) {
		return (b)? blend() : noBlend();
	}

	public boolean hasBlend() {
		return hasBlend;
	}

	public HCanvas blendMode(int i) {
		blendMode = i;
		return this;
	}

	public int blendMode() {
		return blendMode;
	}

	public HCanvas fade(int fadeAmt) {
		hasFade = true;
		this.fadeAmt = fadeAmt;
		return this;
	}

	public HCanvas noFade() {
		hasFade = false;
		return this;
	}

	public HCanvas hasFade(boolean b) {
		hasFade = b;
		return this;
	}

	public boolean hasFade() {
		return hasFade;
	}

	public HCanvas autoClear(boolean b) {
		autoClear = b;
		return this;
	}

	public boolean autoClear() {
		return autoClear;
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
		return fill;
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
	public void paintAll(PGraphics g, boolean zFlag, float alphaPc) {
		if(this.alphaPc <=0 || width ==0 || height ==0) return;

		g.pushMatrix();
			// Rotate and translate
			if(zFlag) g.translate(x, y, z);
			else g.translate(x, y);
			g.rotate(rotationZRad);

			// Compute current alpha
			alphaPc *= this.alphaPc;

			// Initialize the buffer
			graphics.beginDraw();

			// Prepare the buffer for this frame
			if(autoClear) {
				graphics.clear();
			} else {
				if(hasFilter) {
					if(hasFilterParam) graphics.filter(filterKind, filterParam);
					else graphics.filter(filterKind);
				}
				if(hasFade) {
					if(!renderer.equals(PConstants.JAVA2D))
						graphics.loadPixels();

					int[] pix = graphics.pixels;
					for(int i=0; i<pix.length; ++i) {
						int clr = pix[i];
						int a = clr >>> 24;
						if(a == 0) continue;
						a -= fadeAmt;
						if(a < 0) a = 0;
						pix[i] = clr & 0xFFFFFF | (a << 24);
					}
					graphics.updatePixels();
				}
				if(hasBlend) {
					graphics.blend(
						0,0, graphics.width, graphics.height,
						0,0, graphics.width, graphics.height, blendMode);
				}
			}

			// Draw children
			HDrawable child = firstChild;
			while(child != null) {
				child.paintAll(graphics, usesZ(), alphaPc);
				child = child.next();
			}

			if (hasShader) {
				for(PShader s : shader) {
					graphics.filter(s);
				}
			}

			// Finalize the buffer
			graphics.endDraw();

			// Draw the buffer
			g.image(graphics,0,0);
		g.popMatrix();
	}

	@Override
	public void draw(PGraphics g,boolean b,float x,float y,float f) {}
}
