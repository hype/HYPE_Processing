package hype;

import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PImage;

public class HSprite extends HDrawable {
	private PImage texture;
	private int tX, tY;

	public HSprite() {}
	
	public HSprite(float s) {
		size(s);
	}
	
	public HSprite(float w, float h) {
		size(w,h);
	}

	public HSprite texture(Object imgArg) {
		texture = H.getImage(imgArg);

		if(texture == null) {
			tX = 0;
			tY = 0;
		} else {
			tX = texture.width;
			tY = texture.height;
		}
		return this;
	}

	@Override
	public HSprite createCopy() {
		HSprite copy = new HSprite();
		copy.texture = texture;
		copy.tX = tX;
		copy.tY = tY;
		copy.extras = extras;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float alphaPc
	) {
		g.textureMode(PConstants.NORMAL);
		g.noStroke();
		g.tint(fill);

	    g.pushMatrix();
	    	g.translate(drawX, drawY);
	    	g.scale(width, height);

	    	g.beginShape();
		    	g.texture(texture);
				g.vertex(0, 0, 0, 0);
				g.vertex(1, 0, 1, 0);
				g.vertex(1, 1, 1, 1);
				g.vertex(0, 1, 0, 1);
			g.endShape();

		g.popMatrix();
	}
}