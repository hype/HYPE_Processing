package hype;

import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PImage;

public class HBox extends HDrawable3D {

	PImage[] txt;
	PGraphics[] txtPG;
	boolean[] isPgTexture;
	boolean useTexture = false;

	@Override
	public HDrawable createCopy() {
		HBox copy = new HBox();
		copy.copyPropertiesFrom(this);
		copy.depth = depth;
		copy.anchorW = anchorW;
		copy.txt = txt;
		copy.txtPG = txtPG;
		copy.useTexture = useTexture;
		copy.isPgTexture = isPgTexture;
		return copy;
	}

	public HDrawable3D texture(Object imgArg) {
		return textureTop(imgArg);
	}

	public HDrawable3D textureTop(Object imgArg) {
		if (useTexture == false) {
			initTexture(false, 6, imgArg);
		}
		return texture(imgArg, 0);
	}
	public HDrawable3D textureBottom(Object imgArg) {
		if (useTexture == false) {
			initTexture(false, 6, imgArg);
		}
		return texture(imgArg, 5);
	}
	public HDrawable3D textureFront(Object imgArg) {
		if (useTexture == false) {
			initTexture(false, 6, imgArg);
		}
		return texture(imgArg, 1);
	}
	public HDrawable3D textureBack(Object imgArg) {
		if (useTexture == false) {
			initTexture(false, 6, imgArg);
		}
		return texture(imgArg, 4);
	}
	public HDrawable3D textureLeft(Object imgArg) {
		if (useTexture == false) {
			initTexture(false, 6, imgArg);
		}
		return texture(imgArg, 2);
	}
	public HDrawable3D textureRight(Object imgArg) {
		if (useTexture == false) {
			initTexture(false, 6, imgArg);
		}
		return texture(imgArg, 3);
	}




	public HDrawable3D texture(PGraphics imgArg) {
		return textureTop(imgArg);
	}

	public HDrawable3D textureTop(PGraphics imgArg) {
		if (useTexture == false) {
			initTexture(true, 6, imgArg);
		}
		return texture(imgArg, 0);
	}
	public HDrawable3D textureBottom(PGraphics imgArg) {
		if (useTexture == false) {
			initTexture(true, 6, imgArg);
		}
		return texture(imgArg, 5);
	}
	public HDrawable3D textureFront(PGraphics imgArg) {
		if (useTexture == false) {
			initTexture(true, 6, imgArg);
		}
		return texture(imgArg, 1);
	}
	public HDrawable3D textureBack(PGraphics imgArg) {
		if (useTexture == false) {
			initTexture(true, 6, imgArg);
		}
		return texture(imgArg, 4);
	}
	public HDrawable3D textureLeft(PGraphics imgArg) {
		if (useTexture == false) {
			initTexture(true, 6, imgArg);
		}
		return texture(imgArg, 2);
	}
	public HDrawable3D textureRight(PGraphics imgArg) {
		if (useTexture == false) {
			initTexture(true, 6, imgArg);
		}
		return texture(imgArg, 3);
	}


	/**************/

	private void initTexture(boolean pg, int sz, Object imgArg) {

		useTexture = true;
		isPgTexture = new boolean[sz];
		txtPG = new PGraphics[sz];
		txt = new PImage[sz];

		if (pg == true) {
			for (int i = 0; i < sz; ++i) {
				texture((PGraphics) imgArg, i);
			}
		} else {
			for (int i = 0; i < sz; ++i) {
				texture(imgArg, i);
			}
		}
	}

	private HDrawable3D texture(PGraphics imgArg, int idx) {
		txtPG[idx] = imgArg;
		isPgTexture[idx] = true;
		return this;
	}

	private HDrawable3D texture(Object imgArg, int idx) {
		txt[idx] = H.getImage(imgArg);
		isPgTexture[idx] = false;
		return this;
	}

	/*******/


	@Override
	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		applyStyle(g, currAlphaPc);
		g.pushMatrix();
			g.translate(drawX, drawY, -anchorZ());
			g.scale(width,height,depth);

			//scale the strokeWeight back down so it appears normal on screen
			float sw = (float) 1.0/width * strokeWeight;
			float w = 1.0f;
			float h = 1.0f;

			// -Z "back" face
			g.beginShape(PConstants.QUADS);
				g.strokeWeight(sw);

				if (useTexture == true) {
					g.tint(fill);
					g.textureMode(PConstants.NORMAL);
					if (isPgTexture[4] == true) {
						g.texture(txtPG[4]);
					} else {
						g.texture(txt[4]);
					}
				}

				g.vertex( 0.5f, -0.5f, -0.5f, 0, 0);
				g.vertex(-0.5f, -0.5f, -0.5f, w, 0);
				g.vertex(-0.5f,  0.5f, -0.5f, w, h);
				g.vertex( 0.5f,  0.5f, -0.5f, 0, h);

			g.endShape(PConstants.CLOSE);


			// +Y "bottom" face
			g.beginShape(PConstants.QUADS);
				g.strokeWeight(sw);

				if (useTexture == true) {
					g.tint(fill);
					g.textureMode(PConstants.NORMAL);
					if (isPgTexture[5] == true) {
						g.texture(txtPG[5]);
					} else {
						g.texture(txt[5]);
					}
				}

				g.vertex(-0.5f,  0.5f,  0.5f, 0, 0);
				g.vertex( 0.5f,  0.5f,  0.5f, w, 0);
				g.vertex( 0.5f,  0.5f, -0.5f, w, h);
				g.vertex(-0.5f,  0.5f, -0.5f, 0, h);

			g.endShape(PConstants.CLOSE);
			

			// +X "right" face
			g.beginShape(PConstants.QUADS);
				g.strokeWeight(sw);

				if (useTexture == true) {
					g.tint(fill);
					g.textureMode(PConstants.NORMAL);
					if (isPgTexture[3] == true) {
						g.texture(txtPG[3]);
					} else {
						g.texture(txt[3]);
					}
				}

				g.vertex( 0.5f, -0.5f,  0.5f, 0, 0);
				g.vertex( 0.5f, -0.5f, -0.5f, w, 0);
				g.vertex( 0.5f,  0.5f, -0.5f, w, h);
				g.vertex( 0.5f,  0.5f,  0.5f, 0, h);

			g.endShape(PConstants.CLOSE);
			

			// -X "left" face
			g.beginShape(PConstants.QUADS);
				g.strokeWeight(sw);

				if (useTexture == true) {
					g.tint(fill);
					g.textureMode(PConstants.NORMAL);
					if (isPgTexture[2] == true) {
						g.texture(txtPG[2]);
					} else {
						g.texture(txt[2]);
					}
				}

				g.vertex(-0.5f, -0.5f, -0.5f, 0, 0);
				g.vertex(-0.5f, -0.5f,  0.5f, w, 0);
				g.vertex(-0.5f,  0.5f,  0.5f, w, h);
				g.vertex(-0.5f,  0.5f, -0.5f, 0, h);

			g.endShape(PConstants.CLOSE);

			// -Y "top" face
			g.beginShape(PConstants.QUADS);
				g.strokeWeight(sw);

				if (useTexture == true) {
					g.tint(fill);
					g.textureMode(PConstants.NORMAL);
					if (isPgTexture[0] == true) {
						g.texture(txtPG[0]);
					} else {
						g.texture(txt[0]);
					}
				}

				g.vertex(-0.5f, -0.5f, -0.5f, 0, 0);
				g.vertex( 0.5f, -0.5f, -0.5f, w, 0);
				g.vertex( 0.5f, -0.5f,  0.5f, w, h);
				g.vertex(-0.5f, -0.5f,  0.5f, 0, h);

			g.endShape(PConstants.CLOSE);


			// +Z "front" face
			g.beginShape(PConstants.QUADS);
				g.strokeWeight(sw);

				if (useTexture == true) {
					g.tint(fill);
					g.textureMode(PConstants.NORMAL);
					if (isPgTexture[1] == true) {
						g.texture(txtPG[1]);
					} else {
						g.texture(txt[1]);
					}
				}

				g.vertex(-0.5f, -0.5f,  0.5f, 0, 0);
				g.vertex( 0.5f, -0.5f,  0.5f, w, 0);
				g.vertex( 0.5f,  0.5f,  0.5f, w, h);
				g.vertex(-0.5f,  0.5f,  0.5f, 0, h);

			g.endShape(PConstants.CLOSE);
			

		g.popMatrix();
	}
}
