package hype;

import hype.drawable.HDrawable;
import hype.drawable.HEllipse;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	@SuppressWarnings("static-access")
	public void setup(){
		size(500,500);
		H.init(this).background(0);
		
		HDrawable d = H.add(new HEllipse())
			.fill(255,255,255,128).locAt(H.CENTER);
		//d.anchorPerc(0.5f,0.5f);
		//d.anchorPercX(0);
		//d.anchorPercY(2);
		d.anchorAt(H.CENTER_X|H.BOTTOM);
	}

	public void draw() {
		H.drawStage();
		stroke(255);
		line(0,height/2,width,height/2);
		line(width/2,0,width/2,height);
	}
}
