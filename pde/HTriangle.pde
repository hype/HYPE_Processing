public static class HTriangle extends HDrawable {
	protected int _type;
	public HTriangle() {}
	public HTriangle(int triangleType) {
		type(triangleType);
	}
	public HTriangle createCopy() {
		HTriangle copy = new HTriangle();
		copy.copyPropertiesFrom(this);
		copy._type = _type;
		return copy;
	}
	public HTriangle type(int triangleType) {
		_type = triangleType;
		return this;
	}
	public int type() {
		return _type;
	}
	public HTriangle width(float w) {
		if(_type == H.EQUILATERAL) super.height(w * H.app().sin(60*H.D2R));
		return (HTriangle) super.width(w);
	}
	public HTriangle height(float h) {
		if(_type == H.EQUILATERAL) super.width(h / H.app().sin(60*H.D2R));
		return (HTriangle) super.height(h);
	}
	public void draw(PApplet app, float drawX, float drawY, float currAlphaPerc) {
		applyStyle(app,currAlphaPerc);
		float x1;
		float y1;
		float x2;
		float y2;
		float x3;
		float y3;
		if(_type == H.RIGHT) {
			x1 = drawX;
			y1 = drawY;
			x2 = drawX + _width;
			y2 = drawY;
			x3 = drawX + _width;
			y3 = drawY + _height;
		} else {
			x1 = drawX;
			y1 = drawY + _height;
			x2 = drawX + _width/2;
			y2 = drawY;
			x3 = drawX + _width;
			y3 = drawY + _height;
		}
		app.triangle(x1,y1, x2,y2, x3,y3);
	}
}
