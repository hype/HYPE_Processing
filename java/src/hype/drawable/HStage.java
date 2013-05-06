package hype.drawable;

import hype.util.HColorUtil;
import hype.util.HConstants;
import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;
import processing.core.PVector;

public class HStage extends HDrawable {
	protected PApplet _app;
	protected PImage _bgImg;
	protected boolean _autoClearFlag;
	
	public HStage(PApplet papplet) {
		_app = papplet;
		
		_autoClearFlag = true;
		background(HConstants.DEFAULT_BACKGROUND_COLOR);
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
	
	public HStage autoClear(boolean b) {
		_autoClearFlag = b;
		return this;
	}
	
	public boolean autoClears() {
		return _autoClearFlag;
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
		return fill(HColorUtil.merge(255,r,g,b));
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
	public void paintAll(PGraphics g, float currAlphaPerc) {
		g.pushStyle();
			if(_autoClearFlag) clear();
			
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g,1);
				child = child.next();
			}
		g.popStyle();
	}
	
	
	// DEACTIVATED DRAWABLE METHODS //
	
	@Override
	public void draw(PGraphics g,float drawX,float drawY,float currAlphaPerc) {}
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
	public HDrawable rotation(float deg) { return this; }
	@Override
	public HDrawable rotationRad(float rad) { return this; }
	@Override
	public HDrawable rotate(float deg) { return this; }
	@Override
	public HDrawable rotateRad(float rad) { return this; }
}
