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
	 * - [x] js PGraphics hack
	 * - [x] HDrawable.proportional()
	 * - [x] remove HPath.preserveSizeRatio()
	 * - [ ] HMouse._started tweaks
	 * - [ ] HMouse flags
	 */
	
	HDrawable d;
	
	@Override
	public void setup() {
		size(512,512);
		H.init(this);
		
		//d = new HEllipse().scale(random(.5f,1.5f),random(.5f,1.5f)).proportional(true);
		d = new HPath().star(5, H.PHI_1);//.triangle(H.RIGHT, H.LEFT);
		H.add(d);
	}
	
	@Override
	public void draw() {
		H.drawStage();
		//d.size(mouseX-d.x(),mouseY-d.y());
	}
}
