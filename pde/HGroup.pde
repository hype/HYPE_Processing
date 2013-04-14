public static class HGroup extends HDrawable {
	public HGroup createCopy() {
		HGroup copy = new HGroup();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	public void paintAll(PApplet app, float currAlphaPerc) {
		if(_alpha<=0 || _width<=0 || _height<=0) return;
		app.pushMatrix();
			app.translate(_x,_y);
			app.rotate(_rotationRad);
			currAlphaPerc *= _alpha;
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(app,currAlphaPerc);
				child = child.next();
			}
		app.popMatrix();
	}
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {}
}
