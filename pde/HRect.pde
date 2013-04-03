public static class HRect extends HDrawable {
	public float _tl, _tr, _bl, _br;
	public HRect() {
		size(16);
	}
	public HRect(float s) {
		size(s);
	}
	public HRect(float w, float h) {
		size(w,h);
	}
	public HRect(float w, float h, float roundingRadius) {
		size(w,h);
		rounding(roundingRadius);
	}
	public HRect createCopy() {
		HRect copy = new HRect();
		copy._tl = _tl;
		copy._tr = _tr;
		copy._bl = _bl;
		copy._br = _br;
		copy.copyPropertiesFrom(this);
		return copy;
	}
	public HRect rounding(float radius) {
		_tl = _tr = _bl = _br = radius;
		return this;
	}
	public HRect rounding(
		float topleft, float topright,
		float bottomright, float bottomleft
	) {
		_tl = topleft;
		_tr = topright;
		_br = bottomright;
		_bl = bottomleft;
		return this;
	}
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {
		applyStyle(app,currAlphaPerc);
		app.rect(drawX,drawY, _width,_height, _tl,_tr,_br,_bl);
	}
}
