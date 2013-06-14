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

package hype.core.drawable;

import hype.core.util.HColors;
import hype.core.util.HConstants;
import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;
import processing.core.PVector;

public class HStage extends HDrawable {
	private PApplet _app;
	private PImage _bgImg;
	private boolean _autoClears;
	
	public HStage(PApplet papplet) {
		_app = papplet;
		
		_autoClears = true;
		background(HConstants.DEFAULT_BACKGROUND_COLOR);
	}
	
	
	// PARENT & CHILD //
	
	@Override
	public boolean invalidChild(HDrawable destParent) {
		return true;
	}
	
	
	// BACKGROUND //
	
	public void background(int clr) {
		_fill = clr;
		clear();
	}
	
	public void backgroundImg(Object arg) {
		if(arg instanceof String) {
			_bgImg = _app.loadImage((String) arg);
		} else if(arg instanceof PImage) {
			_bgImg = (PImage) arg;
		}
		clear();
	}
	
	/** @deprecated The method autoClears(boolean) should be used instead */
	public HStage autoClear(boolean b) {
		_autoClears = b;
		return this;
	}
	
	public HStage autoClears(boolean b) {
		_autoClears = b;
		return this;
	}
	
	public boolean autoClears() {
		return _autoClears;
	}
	
	public HStage clear() {
		if(_bgImg == null) _app.background(_fill);
		else _app.background(_bgImg);
		return this;
	}
	
	@Override
	public HDrawable fill(int clr) {
		background(clr);
		return this;
	}
	
	@Override
	public HDrawable fill(int clr, int alpha) {
		return fill(clr);
	}
	
	@Override
	public HDrawable fill(int r, int g, int b) {
		return fill(HColors.merge(255,r,g,b));
	}
	
	@Override
	public HDrawable fill(int r, int g, int b, int a) {
		return fill(r,g,b);
	}
	
	
	// SIZE //
	
	@Override
	public PVector size() {
		return new PVector(_app.width,_app.height);
	}
	
	@Override
	public float width() {
		return _app.width;
	}
	
	@Override
	public float height() {
		return _app.height;
	}
	
	
	// PAINTALL //
	
	@Override
	public void paintAll(PGraphics g, boolean usesZ, float currAlphaPc) {
		g.pushStyle();
			if(_autoClears) clear();
			
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, currAlphaPc);
				child = child.next();
			}
		g.popStyle();
	}
	
	
	// DEACTIVATED HDRAWABLE METHODS //
	
	@Override
	public void draw(PGraphics g,boolean b,float x,float y,float p) {}
	@Override
	public void copyPropertiesFrom(HDrawable other) {}
	@Override
	public HDrawable createCopy() { return null; }
	@Override
	public HDrawable loc(float newX, float newY) { return this; }
	@Override
	public HDrawable x(float newX) { return this; }
	@Override
	public HDrawable y(float newY) { return this; }
	@Override
	public HDrawable z(float newY) { return this; }
	@Override
	public HDrawable move(float dx, float dy) { return this; }
	@Override
	public HDrawable locAt(int where) { return this; }
	@Override
	protected void onResize(float oldW, float oldH, float newW, float newH) {}
	@Override
	public HDrawable rotation(float deg) { return this; }
	@Override
	public HDrawable rotationRad(float rad) { return this; }
	@Override
	public HDrawable rotate(float deg) { return this; }
	@Override
	public HDrawable rotateRad(float rad) { return this; }
}
