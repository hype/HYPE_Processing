public static class HStage extends HDrawable {
	protected PApplet _app;
	protected PImage _bgImg;
	protected boolean _autoClearFlag;
	public HStage(PApplet papplet) {
		_app = papplet;
		_autoClearFlag = true;
		background(HConstants.DEFAULT_BACKGROUND_COLOR);
	}
	public void background(int clr) {
		_fill = clr;
		clear();
	}
	public void backgroundImg(Object arg) {
		if(arg instanceof String) {
			_bgImg = _app.loadImage((String) arg);
		} else if(arg instanceof PImage) {
			_bgImg = (PImage) arg;
		}
		clear();
	}
	public HStage autoClear(boolean b) {
		_autoClearFlag = b;
		return this;
	}
	public boolean autoClear() {
		return _autoClearFlag;
	}
	public HStage clear() {
		if(_bgImg == null) _app.background(_fill);
		else _app.background(_bgImg);
		return this;
	}
	public HDrawable fill(int clr) {
		background(clr);
		return this;
	}
	public HDrawable fill(int clr, int alpha) {
		return fill(clr);
	}
	public HDrawable fill(int r, int g, int b) {
		return fill(HColorUtil.merge(255,r,g,b));
	}
	public HDrawable fill(int r, int g, int b, int a) {
		return fill(r,g,b);
	}
	public PVector size() {
		return new PVector(_app.width,_app.height);
	}
	public float width() {
		return _app.width;
	}
	public float height() {
		return _app.height;
	}
	public void paintAll(PApplet app, float currAlphaPerc) {
		app.pushStyle();
			if(_autoClearFlag) clear();
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(app,1);
				child = child.next();
			}
		app.popStyle();
	}
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {}
	public void copyPropertiesFrom(HDrawable other) {}
	public HDrawable createCopy() { return null; }
	public HDrawable loc(float newX, float newY) { return this; }
	public HDrawable x(float newX) { return this; }
	public HDrawable y(float newY) { return this; }
	public HDrawable move(float dx, float dy) { return this; }
	public HDrawable locAt(int where) { return this; }
	public HDrawable rotation(float deg) { return this; }
	public HDrawable rotationRad(float rad) { return this; }
	public HDrawable rotate(float deg) { return this; }
	public HDrawable rotateRad(float rad) { return this; }
}
