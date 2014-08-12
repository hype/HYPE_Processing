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

package hype.extended.colorist;

import hype.core.colorist.HColorist;
import hype.core.drawable.HDrawable;
import hype.core.interfaces.HImageHolder;
import hype.core.util.H;
import hype.extended.drawable.HImage;
import processing.core.PImage;

public class HPixelColorist implements HColorist, HImageHolder {
	private PImage img;
	private boolean fillFlag, strokeFlag;
	
	public HPixelColorist() {
		fillAndStroke();
	}
	
	public HPixelColorist(Object imgArg) {
		this();
		image(imgArg);
	}
	
	@Override
	public HPixelColorist image(Object imgArg) {
		img = H.getImage(imgArg);
		return this;
	}

	@Override
	public PImage image() {
		return img;
	}

	/** @deprecated */
	public HPixelColorist setImage(Object imgArg) {
		if(imgArg instanceof PImage) {
			img = (PImage) imgArg;
		} else if(imgArg instanceof HImage) {
			img = ((HImage) imgArg).image();
		} else if(imgArg instanceof String) {
			img = H.app().loadImage((String) imgArg);
		} else if(imgArg == null) {
			img = null;
		}
		return this;
	}
	
	/** @deprecated */
	public PImage getImage() {
		return img;
	}
	
	public int getColor(float x, float y) {
		return (img==null)? 0 : img.get(Math.round(x), Math.round(y));
	}

	@Override
	public HPixelColorist fillOnly() {
		fillFlag = true;
		strokeFlag = false;
		return this;
	}

	@Override
	public HPixelColorist strokeOnly() {
		fillFlag = false;
		strokeFlag = true;
		return this;
	}

	@Override
	public HPixelColorist fillAndStroke() {
		fillFlag = strokeFlag = true;
		return this;
	}
	
	@Override
	public boolean appliesFill() {
		return fillFlag;
	}
	
	@Override
	public boolean appliesStroke() {
		return strokeFlag;
	}
	
	@Override
	public HDrawable applyColor(HDrawable drawable) {
		int clr = getColor(drawable.x(), drawable.y());
		if(fillFlag)
			drawable.fill(clr);
		if(strokeFlag)
			drawable.stroke(clr);
		return drawable;
	}
}
