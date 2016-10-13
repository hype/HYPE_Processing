// HPyramid based on vertices by Simon Greenwold.
// See https://processing.org/examples/vertices.html
// Can be used to generate pyramids, cylinders or cones...

package hype;

import processing.core.PConstants;
import processing.core.PGraphics;
import static processing.core.PApplet.cos;
import static processing.core.PApplet.sin;

public class HPyramid extends HDrawable3D {
	private int sides; 
	private float topRadius;

	public HPyramid() {
		// four sided pyramid by default
		sides = 4;
		topRadius = 0;
	}

	public HPyramid sides(int s) {
		sides = 4;
		s = Math.abs(s);
		if(s>2) {
			sides = s;
		}
		return this;
	}

	public int sides() {
		return sides;
	}

	public float topRadius() {
		return topRadius;
	}

	public HPyramid topRadius(float tr) {
		topRadius = Math.abs(tr);
		if(topRadius>depth) {
			topRadius=depth;
		}
		return this;
	}

	@Override
	public HDrawable createCopy() {
		HPyramid copy = new HPyramid();
		copy.copyPropertiesFrom(this);
		copy.depth = depth;
		copy.topRadius = topRadius;
		copy.sides = sides;
		copy.anchorW = anchorW;
		return copy;
	}

	@Override
	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		applyStyle(g, currAlphaPc);
		g.pushMatrix();
			g.translate(drawX, drawY-(Math.abs(height)/2), -anchorZ());

			float angle = 0;
			float angleIncrement = PConstants.TWO_PI / sides;

			// draw bottom
			angle = 0;
			g.beginShape(); 
				for (int i = 0; i < sides + 1; i++) {
					g.vertex(Math.abs(depth) * cos(angle), Math.abs(height), Math.abs(depth) * sin(angle)); 
					angle += angleIncrement;
				}
			g.endShape(PConstants.CLOSE);

			// draw top
			if (topRadius != 0) {
				angle = 0;
				g.beginShape();
					for (int i = 0; i < sides + 1; i++) {
						g.vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
						angle += angleIncrement;
					}
				g.endShape();
			}

			// draw sides
			g.beginShape(PConstants.QUAD_STRIP);
				if(sides>8) g.noStroke();
				for (int i = 0; i < sides + 1; ++i) {
					g.vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
					g.vertex(Math.abs(depth)*cos(angle), Math.abs(height), Math.abs(depth)*sin(angle)); 
					angle += angleIncrement;
				}
			g.endShape(PConstants.CLOSE);
		g.popMatrix();
	}
}
