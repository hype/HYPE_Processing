/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HGroup extends HDrawable {
	public HGroup() {
		transformsChildren(true).stylesChildren(true);
	}
	public HGroup createCopy() {
		HGroup copy = new HGroup();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	public void paintAll(PGraphics g, boolean usesZ, float alphaPc) {
		if(_alphaPc<=0) return;
		g.pushMatrix();
			if(usesZ) g.translate(_x,_y,_z);
			else g.translate(_x,_y);
			g.rotate(_rotationZRad);
			alphaPc *= _alphaPc;
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, alphaPc);
				child = child.next();
			}
		g.popMatrix();
	}
	public void draw(PGraphics g,boolean b,float x,float y,float f) {}
}
