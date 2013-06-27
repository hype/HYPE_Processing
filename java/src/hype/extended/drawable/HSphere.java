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

import hype.core.drawable.HDrawable3D;
import processing.core.PGraphics;

public class HSphere extends HDrawable3D {
	public HSphere() {}
	
	public HSphere(float radius) {
		radius(radius);
	}
	
	public HSphere(float radiusw, float radiush, float radiusd) {
		radius(radiusw, radiush, radiusd);
	}
	
	public HSphere radius(float f) {
		return (HSphere) size(f*2);
	}
	
	public HSphere radius(float radiusw, float radiush, float radiusd) {
		return (HSphere) size(radiusw*2, radiush*2, radiusd*2);
	}
	
	@Override
	protected void onResize(float oldW, float oldH, float newW, float newH) {
		_height = _depth = _width;
		super.onResize(oldW, oldH, newW, newH);
	}
	
	@Override
	public HSphere createCopy() {
		HSphere copy = new HSphere();
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
			g.translate(drawX+_width/2, drawY+_height/2, -anchorZ()+_depth/2);
			g.scale(_width, _height, _depth);
			g.sphere(1);
		g.popMatrix();
	}

}
