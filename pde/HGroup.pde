public static class HGroup extends HDrawable {
	public HGroup createCopy() {
		HGroup copy = new HGroup();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	public void paintAll(PGraphics g, float currAlphaPerc) {
		if(_alpha<=0) return;
		g.pushMatrix();
			if(H.uses3D()) g.translate(_x,_y,_z);
			else g.translate(_x,_y);
			g.rotate(_rotationRad);
			currAlphaPerc *= _alpha;
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g,currAlphaPerc);
				child = child.next();
			}
		g.popMatrix();
	}
	public void draw(PGraphics g,float drawX,float drawY,float currAlphaPerc) {}
}
