package hype;

import hype.behavior.HSwarm;
import hype.drawable.HCanvas;
import hype.drawable.HRect;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("static-access")
	@Override
	public void setup() {
		size(1024,512);
		H.init(this).background(H.WHITE);
		
		HSwarm swarm = new HSwarm().speed(4).turnEase(0.05f).twitch(15).addGoal(width/2,height/2);
		
		HCanvas canvas = new HCanvas().background(H.WHITE).fade(32);
		H.add(canvas);
		
		int i = 128;
		while(i-->0) swarm.addTarget(canvas.add(new HRect(12,4).rounding(2).alpha(128)).anchorAt(H.CENTER).locAt(H.CENTER));
	}
	
	@Override
	public void draw() {
		H.drawStage();
	}
}
