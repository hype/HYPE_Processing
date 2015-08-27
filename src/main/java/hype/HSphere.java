package hype;

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
		height = depth = width;
		super.onResize(oldW, oldH, newW, newH);
	}

	@Override
	public HSphere createCopy() {
		HSphere copy = new HSphere();
		copy.copyPropertiesFrom(this);
		copy.depth = depth;
		copy.anchorW = anchorW;
		return copy;
	}

	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float currAlphaPc
	) {
		applyStyle(g, currAlphaPc);
		g.pushMatrix();
			g.translate(drawX+ width /2, drawY+ height /2, -anchorZ()+ depth /2);
			//g.scale(width, height, depth);
			//g.sphere(1);

			/*
				Hot fix for weird stroke on sphere when scaling
				TODO: need to look at this again to make it better
			*/
			g.sphere(width);

		g.popMatrix();
	}

}
