package hype;

import hype.drawable.HDrawable;
import hype.drawable.HPath;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	HDrawable d;
	
	@SuppressWarnings("static-access")
	@Override
	public void setup() {
		size(512,512);
		noLoop();
		H.init(this).background(H.WHITE);
		
		d = new HPath().star(5,.5f,30);
		H.add(d);
		//
	}
	
	@Override
	public void draw() {
		H.drawStage();
		stroke(H.MAGENTA,128);
		for(int y=0; y<height; ++y) for(int x=0; x<width; ++x) {
			if(d.contains(x,y)) point(x,y);
		}
	}
}
