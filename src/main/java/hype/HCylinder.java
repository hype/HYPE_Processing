package hype;

import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PImage;

import static processing.core.PApplet.cos;
import static processing.core.PApplet.sin;
import static processing.core.PApplet.radians;

public class HCylinder extends HDrawable3D {

	float radiusTop;
	float radiusBottom;
	boolean drawTop;
	boolean drawBottom;
	boolean strokeSides;
	int numSides;

	PImage txt;
	PGraphics txtPG;
	boolean isPgTexture;
	boolean useTexture = false;

	public HCylinder() {

		radiusTop = 0.5f;
		radiusBottom = 0.5f;
		drawTop = true;
		drawBottom = true;
		strokeSides = false;

		numSides = 72;//default to a smoothish cylinder
		
	}

	@Override
	public HCylinder createCopy() {
		HCylinder copy = new HCylinder();
		copy.copyPropertiesFrom(this);
		copy.depth = depth;
		copy.radiusTop = radiusTop;
		copy.radiusBottom = radiusBottom;
		copy.drawTop = drawTop;
		copy.drawBottom = drawBottom;
		copy.numSides = numSides;
		copy.strokeSides = strokeSides;

		copy.txt = txt;
		copy.txtPG = txtPG;
		copy.useTexture = useTexture;
		copy.isPgTexture = isPgTexture;
		return copy;
	}

	public HCylinder sides(int i) {
		if (i < 3) i = 3;//don't allow less than 3 sides or it's not a cylinder shape
		numSides = i;
		return this;
	}

	public int sides() {
		return numSides;
	}

	public HCylinder drawTop(boolean b) {
		drawTop = b;
		return this;
	}

	public HCylinder drawBottom(boolean b) {
		drawBottom = b;
		return this;
	}

	public boolean drawTop() {
		return drawTop;
	}

	public boolean drawBottom() {
		return drawBottom;
	}

	public HCylinder strokeSides(boolean b) {
		strokeSides = b;
		return this;
	}

	public boolean strokeSides() {
		return strokeSides;
	}


	public HCylinder topRadius(float f) {
		radiusTop = f;
		return this;
	}

	public HCylinder bottomRadius(float f) {
		radiusBottom = f;
		return this;
	}

	public float topRadius() {
		return radiusTop;
	}

	public float bottomRadius() {
		return radiusBottom;
	}



	public HCylinder texture(PGraphics imgArg) {
		txtPG = imgArg;
		isPgTexture = true;
		useTexture = true;
		return this;
	}

	public HCylinder texture(Object imgArg) {
		txt = H.getImage(imgArg);
		isPgTexture = false;
		useTexture = true;
		return this;
	}



	@Override
	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		
		applyStyle(g, currAlphaPc);
		
		g.pushMatrix();
			g.translate(drawX, drawY, -anchorZ());
			g.scale(width,height,depth);

			//scale the strokeWeight back down so it appears normal on screen
			float sw = (float) 1.0/width * strokeWeight;

			float angle = 0.0f;
			float angleInc = PConstants.TWO_PI / numSides;

			//top plane
			if (drawTop == true && radiusTop != 0.0f) {
				angle = 0.0f;
				g.beginShape();
				g.strokeWeight(sw);

				for(int i = 0; i <= numSides; i++) {
					float x = radiusTop * cos(angle);
					float z = radiusTop * sin(angle);

					g.vertex(x, -0.5f, z);
					angle += angleInc;
				}
				g.endShape(PConstants.CLOSE);
			}

			//bottom plane
			if (drawBottom == true && radiusBottom != 0.0f) {
				angle = 0.0f;
				g.beginShape();
				g.strokeWeight(sw);

				for(int i = 0; i <= numSides; i++) {
					float x = radiusBottom * cos(angle);
					float z = radiusBottom * sin(angle);

					g.vertex(x, 0.5f, z);
					angle += angleInc;
				}
				g.endShape(PConstants.CLOSE);
			}

			//sides
			angle = 0.0f;
			g.beginShape(PConstants.QUAD_STRIP);
			
			if (strokeSides == true)
				g.strokeWeight(sw);
			else
				g.noStroke();


			if (useTexture == true) {

				g.tint(fill);
				g.textureMode(PConstants.NORMAL);
				if (isPgTexture == true) {
					g.texture(txtPG);
				} else {
					g.texture(txt);
				}
			}

			for(int i = 0; i <= numSides; i++) {
				float xTop = radiusTop * cos(angle);
				float zTop = radiusTop * sin(angle);

				float xBottom = radiusBottom * cos(angle);
				float zBottom = radiusBottom * sin(angle);

				float txtX = 1.0f / numSides * i;

				g.vertex(xTop, -0.5f, zTop, txtX, 0);
				g.vertex(xBottom, 0.5f, zBottom, txtX, 1);

				//we minus here because we want the texture facing the outside of the cylinder
				//if we use += the verts are drawn with the texture facing the inside
				angle -= angleInc;
			}
			g.endShape();



		g.popMatrix();
	}
}
