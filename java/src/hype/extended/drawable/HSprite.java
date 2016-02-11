 /*
 *
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013-2015 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 *
 * ----- *
 * HSprite - originally by Benjamin Fox (@tracerstar) *
 * Updated by GD (@Garth_D) - Feb 16 - to enable alpha transparency and to work with new processing 3.0 library form*
 * Tested using processing 3.0.1 (It may break on newer versions of processing) *
 * If you find any issues or make anything cool with this, let me know on twitter at @Garth_D *
 */

package hype;
import hype.interfaces.HImageHolder;

import processing.core.PImage;
import processing.core.PGraphics;

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
		g.textureMode(g.NORMAL); 
		g.noStroke();
		//g.tint(fill); 
		alphaPc *= (fill >>>24);

		g.tint( fill | 0xFF000000, Math.round(alphaPc) ); //update to allow both fill and alpha to be set

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

