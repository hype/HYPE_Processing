public static class HEllipse extends HDrawable {
	public HEllipse() {}
	public HEllipse(float ellipseRadius) {
		radius(ellipseRadius);
	}
	public HEllipse(float radiusX, float radiusY) {
		radius(radiusX,radiusY);
	}
	public HEllipse createCopy() {
		HEllipse copy = new HEllipse();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	public HEllipse radius(float r) {
		size(r*2);
		return this;
	}
	public HEllipse radius(float radiusX, float radiusY) {
		size(radiusX*2,radiusY*2);
		return this;
	}
	public HEllipse radiusX(float radiusX) {
		width(radiusX * 2);
		return this;
	}
	public float radiusX() {
		return _width/2;
	}
	public HEllipse radiusY(float radiusY) {
		height(radiusY * 2);
		return this;
	}
	public float radiusY() {
		return _height/2;
	}
	public boolean isCircle() {
		return _width == _height;
	}
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {
		applyStyle(app,currAlphaPerc);
		app.ellipse(drawX+_width/2, drawY+_height/2, _width, _height);
	}
}
