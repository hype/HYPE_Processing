package hype;

import hype.behavior.HFollow;
import hype.behavior.HOscillator;
import hype.behavior.HSwarm;
import hype.behavior.HTimer;
import hype.colorist.HColorPool;
import hype.drawable.HDrawable;
import hype.drawable.HEllipse;
import hype.util.H;
import hype.util.HCallback;
import hype.util.HDrawablePool;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	private HDrawablePool pool;
	private HColorPool colors;
	private HSwarm swarm;
	
	@SuppressWarnings("static-access")
	public void setup(){
		size(500,500,JAVA2D);
		H.init(this);
		
		HDrawable d = H.add(new HEllipse(32)).fill(0xFF404040).locAt(H.CENTER)
			.anchorAt(H.CENTER);
		HOscillator osc = new HOscillator()
			.relativeVal(1).range(-.5f, .5f)
			.property(H.SCALE)
			.target(d);
		
//		colors = new HColorPool(
//				0xFFFFFFFF, 0xFFF7F7F7, 0xFFECECEC, 0xFF333333,
//				0xFF0095a8, 0xFF00616f, 0xFFFF3300, 0xFFFF6600)
//			.fillOnly();
//		
//		swarm = new HSwarm()
//			.goal(width/2,height/2)
//			.speed(4)
//			.turnEase(0.05f)
//			.twitch(20)
//			//.unregisterBehavior()
//			//.registerBehavior()
//		;
//		
//		pool = new HDrawablePool(64);
//		pool.autoAddToStage()
//			.add(new HEllipse().stroke(0,255).alpha(128))
//			.setOnCreate(new HCallback() { public void run(Object obj) {
//				HDrawable circ = (HDrawable) obj;
//				colors.applyColor(circ);
//				swarm.addTarget(circ);
//				}});
//		new HFollow().target(swarm);
//		new HTimer().numCycles(pool.numActive()).interval(60)._callback = new HCallback() { public void run(Object obj) {
//			pool.request();
//		}};
	}

	public void draw() {
		H.drawStage();
	}
}
