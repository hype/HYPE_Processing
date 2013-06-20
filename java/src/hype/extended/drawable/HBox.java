/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.extended.drawable;

import hype.core.drawable.HDrawable;
import hype.core.drawable.HDrawable3D;
import processing.core.PGraphics;

public class HBox extends HDrawable3D {
	@Override
	public HDrawable createCopy() {
		HBox copy = new HBox();
		copy.copyPropertiesFrom(this);
		copy._depth = _depth;
		copy._anchorW = _anchorW;
		return copy;
	}

	@Override
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
