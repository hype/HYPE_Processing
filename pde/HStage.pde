/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HStage extends HDrawable implements HImageHolder {
	private PApplet _app;
	private PImage _bgImg;
	private boolean _autoClears;
	private boolean _showsFPS;
	public HStage(PApplet papplet) {
		_app = papplet;
		_autoClears = true;
		background(HConstants.DEFAULT_BACKGROUND_COLOR);
	}
	public boolean invalidChild(HDrawable destParent) {
		return true;
	}
	public HStage background(int clr) {
		_fill = clr;
		return clear();
	}
	public HStage backgroundImg(Object arg) {
		return image(arg);
	}
	public HStage image(Object imgArg) {
		_bgImg = H.getImage(imgArg);
		return clear();
	}
	public PImage image() {
		return _bgImg;
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
	public HDrawable fill(int clr) {
		background(clr);
		return this;
	}
	public HDrawable fill(int clr, int alpha) {
		return fill(clr);
	}
	public HDrawable fill(int r, int g, int b) {
		return fill(HColors.merge(255,r,g,b));
	}
	public HDrawable fill(int r, int g, int b, int a) {
		return fill(r,g,b);
	}
	public PVector size() {
		return new PVector(_app.width,_app.height);
	}
	public float width() {
		return _app.width;
	}
	public float height() {
		return _app.height;
	}
	public HStage showsFPS(boolean b) {
		_showsFPS = b;
		return this;
	}
	public boolean showsFPS() {
		return _showsFPS;
	}
	public void paintAll(PGraphics g, boolean usesZ, float currAlphaPc) {
		g.pushStyle();
			if(_autoClears) clear();
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, currAlphaPc);
				child = child.next();
			}
		g.popStyle();
		if(_showsFPS) {
			g.pushStyle();
				g.fill(H.BLACK);
				g.text(_app.frameRate,1,17);
				g.fill(H.WHITE);
				g.text(_app.frameRate,0,16);
			g.popStyle();
		}
	}
	public void draw(PGraphics g,boolean b,float x,float y,float p) {}
	public HDrawable createCopy() { return null; }
}
