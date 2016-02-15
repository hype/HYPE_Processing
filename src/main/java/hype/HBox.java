package hype;

import processing.core.PGraphics;

public class HBox extends HDrawable3D {
	@Override
	public HDrawable createCopy() {
		HBox copy = new HBox();
		copy.copyPropertiesFrom(this);
		copy.depth = depth;
		copy.anchorW = anchorW;
		return copy;
	}

	@Override
	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		applyStyle(g, currAlphaPc);
		g.pushMatrix();
			g.translate(drawX, drawY, -anchorZ());
			g.box(width,height,depth);
		g.popMatrix();
	}
}
