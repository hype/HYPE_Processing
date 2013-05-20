public static class HGroup extends HDrawable {
	public HGroup createCopy() {
		HGroup copy = new HGroup();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	public void paintAll(PGraphics g, boolean usesZ, float currAlphaPerc) {
		if(_alphaPerc<=0) return;
		g.pushMatrix();
			if(usesZ) g.translate(_x,_y,_z);
			else g.translate(_x,_y);
			g.rotate(_rotationRad);
			currAlphaPerc *= _alphaPerc;
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, currAlphaPerc);
				child = child.next();
			}
		g.popMatrix();
	}
	public void draw(PGraphics g,boolean b,float x,float y,float f) {}
}
