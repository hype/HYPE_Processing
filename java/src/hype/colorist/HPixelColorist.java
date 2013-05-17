package hype.colorist;

import hype.drawable.HDrawable;
import hype.drawable.HImage;
import hype.util.H;
import processing.core.PImage;

public class HPixelColorist implements HColorist {
	protected PImage img;
	protected boolean fillFlag, strokeFlag;
	
	public HPixelColorist() {
		fillAndStroke();
	}
	
	public HPixelColorist(Object imgArg) {
		this();
		setImage(imgArg);
	}
	
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
