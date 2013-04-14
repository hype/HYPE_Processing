package hype.drawable;

import hype.util.H;
import hype.util.HColorUtil;
import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;

public class HStage extends HDrawable {
	protected PApplet _app;
	protected PImage _bgImg;
	protected boolean _autoClearFlag, _mouseStarted;
	
	public HStage(PApplet papplet) {
		_app = papplet;
		
		_autoClearFlag = true;
		_app.background(H.DEFAULT_BACKGROUND_COLOR);
	}
	
	@Override
	public HDrawable createCopy() {
		return null;
	}
	
	public void background(int clr) {
		_fill = clr;
		clear();
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
	
	public boolean autoClear() {
		return _autoClearFlag;
	}
	
	public HStage clear() {
		if(_bgImg == null) _app.background(_fill);
		else _app.background(_bgImg);
		return this;
	}
	
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
	
	@Override
	public float followableX() {
		return _app.mouseX;
	}
	
	@Override
	public float followableY() {
		return _app.mouseY;
	}
	
	public boolean mouseStarted() {
		return _mouseStarted;
	}
	
	@Override
	public void paintAll(PApplet app, float currAlphaPerc) {
		if(!_mouseStarted && _app.pmouseX+_app.pmouseY > 0)
			_mouseStarted = true;
		
		app.pushStyle();
			if(_autoClearFlag) clear();
			
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(app,1);
				child = child.next();
			}
		app.popStyle();
	}
	
	@Override
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {}
}
