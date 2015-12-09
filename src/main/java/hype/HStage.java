package hype;

import hype.interfaces.HImageHolder;
import hype.interfaces.HConstants;
import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;
import processing.core.PVector;

public class HStage extends HDrawable implements HImageHolder {
	private PApplet app;
	private PImage bgImg;
	private boolean autoClears;
	private boolean showsFPS;

	public HStage(PApplet papplet) {
		app = papplet;

		autoClears = true;
		background(HConstants.DEFAULT_BACKGROUND_COLOR);
	}


	// PARENT & CHILD //

	@Override
	public boolean invalidChild(HDrawable destParent) {
		return true;
	}


	// BACKGROUND //

	public HStage background(int clr) {
		fill = clr;
		return clear();
	}

	public HStage backgroundImg(Object arg) {
		return image(arg);
	}

	@Override
	public HStage image(Object imgArg) {
		bgImg = H.getImage(imgArg);
		return clear();
	}


	@Override
	public PImage image() {
		return bgImg;
	}

	/** @deprecated The method autoClears(boolean) should be used instead */
	public HStage autoClear(boolean b) {
		autoClears = b;
		return this;
	}

	public HStage autoClears(boolean b) {
		autoClears = b;
		return this;
	}

	public boolean autoClears() {
		return autoClears;
	}

	public HStage clear() {
		if(bgImg == null) app.background(fill);
		else app.background(bgImg);
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
		return new PVector(app.width, app.height);
	}

	@Override
	public float width() {
		return app.width;
	}

	@Override
	public float height() {
		return app.height;
	}


	// MISC //

	public HStage showsFPS(boolean b) {
		showsFPS = b;
		return this;
	}

	public boolean showsFPS() {
		return showsFPS;
	}

	@Override
	public void paintAll(PGraphics g, boolean usesZ, float currAlphaPc) {
		g.pushStyle();
			if(autoClears) clear();

			HDrawable child = firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, currAlphaPc);
				child = child.next();
			}
		g.popStyle();

		if(showsFPS) {
			g.pushStyle();
				g.fill(H.BLACK);
				g.text(app.frameRate,1,17);
				g.fill(H.WHITE);
				g.text(app.frameRate,0,16);
			g.popStyle();
		}
	}


	// DEACTIVATED HDRAWABLE METHODS //

	@Override
	public void draw(PGraphics g,boolean b,float x,float y,float p) {}
	@Override
	public HDrawable createCopy() { return null; }
}
