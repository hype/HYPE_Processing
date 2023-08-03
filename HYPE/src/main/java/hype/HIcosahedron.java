/*
	Icoshedron vertex points/faces positioning taken from:
	http://blog.andreaskahler.com/2009/06/creating-icosphere-mesh-in-code.html 
*/
package hype;

import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PVector;
import java.util.ArrayList;

public class HIcosahedron extends HDrawable3D {

	ArrayList<PVector> v;

	public HIcosahedron() {
		depth = DEFAULT_DEPTH;//not sure I need this?

		v = new ArrayList<PVector>();

		float t = 1.61803399f / 2.0f;//half golden ration to make icos unit radius .5

		v.add(new PVector(-0.5f,  t,  0));
		v.add(new PVector( 0.5f,  t,  0));
		v.add(new PVector(-0.5f, -t,  0));
		v.add(new PVector( 0.5f, -t,  0));
		v.add(new PVector( 0, -0.5f,  t));
		v.add(new PVector( 0,  0.5f,  t));
		v.add(new PVector( 0, -0.5f, -t));
		v.add(new PVector( 0,  0.5f, -t));
		v.add(new PVector( t,  0, -0.5f));
		v.add(new PVector( t,  0,  0.5f));
		v.add(new PVector(-t,  0, -0.5f));
		v.add(new PVector(-t,  0,  0.5f));
	}


	@Override
	public HDrawable createCopy() {
		HIcosahedron copy = new HIcosahedron();
		copy.copyPropertiesFrom(this);
		copy.depth = depth;
		copy.anchorW = anchorW;
		copy.v = v;
		return copy;
	}


	@Override
	public void drawPrimitive(PGraphics g, boolean usesZ, float drawX, float drawY, float alphaPc) {
		applyStyle(g, alphaPc);
		g.pushMatrix();
			g.translate(drawX, drawY, -anchorZ());
			g.scale(width,height,depth);

			//scale the strokeWeight back down so it appears normal on screen
			float sw = (float) 1.0/width * strokeWeight;
			g.strokeWeight(sw);
			
			g.beginShape(PConstants.TRIANGLES);

				// 5 faces around point 0
				g.vertex(v.get(0).x, v.get(0).y, v.get(0).z);
				g.vertex(v.get(11).x, v.get(11).y, v.get(11).z);
				g.vertex(v.get(5).x, v.get(5).y, v.get(5).z);

				g.vertex(v.get(0).x, v.get(0).y, v.get(0).z);
				g.vertex(v.get(5).x, v.get(5).y, v.get(5).z);
				g.vertex(v.get(1).x, v.get(1).y, v.get(1).z);

				g.vertex(v.get(0).x, v.get(0).y, v.get(0).z);
				g.vertex(v.get(1).x, v.get(1).y, v.get(1).z);
				g.vertex(v.get(7).x, v.get(7).y, v.get(7).z);

				g.vertex(v.get(0).x, v.get(0).y, v.get(0).z);
				g.vertex(v.get(7).x, v.get(7).y, v.get(7).z);
				g.vertex(v.get(10).x, v.get(10).y, v.get(10).z);

				g.vertex(v.get(0).x, v.get(0).y, v.get(0).z);
				g.vertex(v.get(10).x, v.get(10).y, v.get(10).z);
				g.vertex(v.get(11).x, v.get(11).y, v.get(11).z);

				// 5 adjacent faces
				g.vertex(v.get(1).x, v.get(1).y, v.get(1).z);
				g.vertex(v.get(5).x, v.get(5).y, v.get(5).z);
				g.vertex(v.get(9).x, v.get(9).y, v.get(9).z);

				g.vertex(v.get(5).x, v.get(5).y, v.get(5).z);
				g.vertex(v.get(11).x, v.get(11).y, v.get(11).z);
				g.vertex(v.get(4).x, v.get(4).y, v.get(4).z);

				g.vertex(v.get(11).x, v.get(11).y, v.get(11).z);
				g.vertex(v.get(10).x, v.get(10).y, v.get(10).z);
				g.vertex(v.get(2).x, v.get(2).y, v.get(2).z);

				g.vertex(v.get(10).x, v.get(10).y, v.get(10).z);
				g.vertex(v.get(7).x, v.get(7).y, v.get(7).z);
				g.vertex(v.get(6).x, v.get(6).y, v.get(6).z);

				g.vertex(v.get(7).x, v.get(7).y, v.get(7).z);
				g.vertex(v.get(1).x, v.get(1).y, v.get(1).z);
				g.vertex(v.get(8).x, v.get(8).y, v.get(8).z);

				// 5 faces around point 3
				g.vertex(v.get(3).x, v.get(3).y, v.get(3).z);
				g.vertex(v.get(9).x, v.get(9).y, v.get(9).z);
				g.vertex(v.get(4).x, v.get(4).y, v.get(4).z);

				g.vertex(v.get(3).x, v.get(3).y, v.get(3).z);
				g.vertex(v.get(4).x, v.get(4).y, v.get(4).z);
				g.vertex(v.get(2).x, v.get(2).y, v.get(2).z);

				g.vertex(v.get(3).x, v.get(3).y, v.get(3).z);
				g.vertex(v.get(2).x, v.get(2).y, v.get(2).z);
				g.vertex(v.get(6).x, v.get(6).y, v.get(6).z);

				g.vertex(v.get(3).x, v.get(3).y, v.get(3).z);
				g.vertex(v.get(6).x, v.get(6).y, v.get(6).z);
				g.vertex(v.get(8).x, v.get(8).y, v.get(8).z);

				g.vertex(v.get(3).x, v.get(3).y, v.get(3).z);
				g.vertex(v.get(8).x, v.get(8).y, v.get(8).z);
				g.vertex(v.get(9).x, v.get(9).y, v.get(9).z);

				// 5 adjacent faces
				g.vertex(v.get(4).x, v.get(4).y, v.get(4).z);
				g.vertex(v.get(9).x, v.get(9).y, v.get(9).z);
				g.vertex(v.get(5).x, v.get(5).y, v.get(5).z);

				g.vertex(v.get(2).x, v.get(2).y, v.get(2).z);
				g.vertex(v.get(4).x, v.get(4).y, v.get(4).z);
				g.vertex(v.get(11).x, v.get(11).y, v.get(11).z);

				g.vertex(v.get(6).x, v.get(6).y, v.get(6).z);
				g.vertex(v.get(2).x, v.get(2).y, v.get(2).z);
				g.vertex(v.get(10).x, v.get(10).y, v.get(10).z);

				g.vertex(v.get(8).x, v.get(8).y, v.get(8).z);
				g.vertex(v.get(6).x, v.get(6).y, v.get(6).z);
				g.vertex(v.get(7).x, v.get(7).y, v.get(7).z);

				g.vertex(v.get(9).x, v.get(9).y, v.get(9).z);
				g.vertex(v.get(8).x, v.get(8).y, v.get(8).z);
				g.vertex(v.get(1).x, v.get(1).y, v.get(1).z);

			g.endShape(PConstants.CLOSE);

		g.popMatrix();
	}
}
