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
public static class HBox extends HDrawable3D {
	public HDrawable createCopy() {
		HBox copy = new HBox();
		copy.copyPropertiesFrom(this);
		copy._depth = _depth;
		copy._anchorW = _anchorW;
		return copy;
	}
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float currAlphaPc
	) {
		applyStyle(g, currAlphaPc);
		g.pushMatrix();
			g.translate(drawX, drawY, -anchorZ());
			g.box(_width,_height,_depth);
		g.popMatrix();
	}
}
