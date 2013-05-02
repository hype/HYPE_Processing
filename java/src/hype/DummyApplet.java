package hype;

import hype.drawable.HDrawable;
import hype.drawable.HPath;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	/*
	 * TODO
	 * - [x] triangle stuff
	 * - [x] hype update script
	 * - [ ] js PGraphics hack
	 * - [ ] move HPath.preserveSizeRatio() to HDrawable
	 */
	
	HDrawable d;
	
	@SuppressWarnings("static-access")
	@Override
	public void setup() {
		size(512,512);
		noLoop();
		H.init(this).background(H.WHITE);
		
		d = new HPath().triangle(H.EQUILATERAL, H.TOP);
		H.add(d).size(15,100);
	}
	
	@Override
	public void draw() {
		H.drawStage();
//		stroke(H.MAGENTA,128);
//		for(int y=0; y<height; ++y) for(int x=0; x<width; ++x) {
//			if(d.contains(x,y)) point(x,y);
//		}
	}
}
