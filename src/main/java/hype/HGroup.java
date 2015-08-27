package hype;

import processing.core.PGraphics;

public class HGroup extends HDrawable {

	public HGroup() {
		transformsChildren(true).stylesChildren(true);
	}

	@Override
	public HGroup createCopy() {
		HGroup copy = new HGroup();
		copy.copyPropertiesFrom(this);
		return copy;
	}

	@Override
	public void paintAll(PGraphics g, boolean usesZ, float alphaPc) {
		if(this.alphaPc <=0) return;

		// Perform a trimmed down version of super.paintAll()
		g.pushMatrix();
			if(usesZ) g.translate(x, y, z);
			else g.translate(x, y);
			g.rotate(rotationZRad);

			alphaPc *= this.alphaPc;

			HDrawable child = firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, alphaPc);
				child = child.next();
			}
		g.popMatrix();
	}

	@Override
	public void draw(PGraphics g,boolean b,float x,float y,float f) {}
}
