package hype;

import hype.behavior.HSwarm;
import hype.drawable.HDrawable;
import hype.drawable.HPath;
import hype.drawable.HRect;
import hype.drawable.HShape;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	/*
	 * TODO
	 * - [x] HDrawable.proportional()
	 * - [x] remove HPath.preserveSizeRatio()
	 * - [x] HMouse._started tweaks
	 * 
	 * - [x] Z-axis on HDrawable
	 * 
	 * - [ ] flipping via width() & height() / allow negative width & height
	 * 	- [x] HImage
	 * 	- [x] HPath
	 * 	- [ ] HShape
	 * 	- [x] HText
	 * - [x] Z-axis on HSwarm & HLocatable
	 * - [ ] HDrawable.firstChild(), HDrawable.lastChild();
	 * - [ ] issue #10
	 * - [ ] HMouse flags
	 * 
	 * - [ ] Standardize boolean getters
	 */
	
	@Override
	public void setup() {
		size(512,512);
		H.init(this);
		
//		H.add(new HImage("Tux.png")).scale(1,1).locAt(H.CENTER).anchorAt(H.CENTER);
//		H.add(new HText("hey")).scale(-1,1).locAt(H.CENTER).anchorAt(H.CENTER);
		HDrawable d = H.add(new HShape("bot1.svg")).scale(-1,1).locAt(H.CENTER).anchorAt(H.CENTER);
//		H.add(new HPath().vertexPerc(0,0).vertexPerc(1,0).vertexPerc(0,1)).locAt(H.CENTER).width(64).height(64).strokeWeight(2);
		H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
		H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
		
		HSwarm s = new HSwarm().idleGoal(width/2,height/2).addGoal(width*3/4,height*3/4).twitch(30).turnEase(.05f).speed(4);
		for(int i=0; i<40; ++i) {
			s.addTarget(H.add(new HRect().size(16,4)).anchorAt(H.CENTER));
		}
		
		//new HFollow().target(d);
		//new HVelocity().target(d).accel(1,45);
	}
	
	@Override
	public void draw() {
		H.drawStage();
		
//		PImage img = loadImage("Tux.png");
		//noLoop();//
	}
}
