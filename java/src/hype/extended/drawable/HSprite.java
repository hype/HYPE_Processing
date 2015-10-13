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
import processing.core.PGraphics;

public class HSprite extends HDrawable {
	
	private PImage _texture;
	private int _tX, _tY;

	
	public HSprite() {}
	
	public HSprite(float s) {
		size(s);
	}
	
	public HSprite(float w, float h) {
		size(w,h);
	}

	public HSprite texture(Object imgArg) {
		_texture = H.getImage(imgArg);

		if(_texture == null) {
			_tX = 0;
			_tY = 0;
		} else {
			_tX = _texture.width;
			_tY = _texture.height;
		}

		return this;
	}

	@Override
	public HSprite createCopy() {
		HSprite copy = new HSprite();
		copy._texture = _texture;
		copy._tX = _tX;
		copy._tY = _tY;
		copy._extras = _extras;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	
	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float alphaPc
	) {

		g.textureMode(NORMAL);
		g.noStroke();
		g.tint(_fill);

	    g.pushMatrix();
	    	g.translate(drawX, drawY);
	    	g.scale(_width, _height);

	    	g.beginShape();
		    	g.texture(_texture);
				g.vertex(0, 0, 0, 0);
				g.vertex(1, 0, 1, 0);
				g.vertex(1, 1, 1, 1);
				g.vertex(0, 1, 0, 1);
			g.endShape();

		g.popMatrix();
		
	}
}
