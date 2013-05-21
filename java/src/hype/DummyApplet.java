package hype;

import hype.behavior.HTween;
import hype.drawable.HDrawable;
import hype.drawable.HPath;
import hype.drawable.HRect;
import hype.interfaces.HCallback;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	/* TODO
	 * - [ ] bool(boolean) for HBundle
	 * - [ ] HPath: base size for computing perc vertex stuff = 100, if size = 0
	 * 
	 * - [ ] HDrawable.transformChildren(bool)
	 * - [ ] recursive spatial transforms for HDrawable & HGroup
	 * 
	 * - [ ] documentation update script
	 * - [ ] pointInScreen(x,y,z)
	 * 
	 * - [ ] HShape hit detection + pgraphics buffer
	 * - [ ] disable style for HShape in P3D
	 * - [ ] use pgraphics buffer for HText + use that for hitbox checking
	 * - [ ] bezier hitbox for HPath
	 * 
	 * - [ ] masking
	 * - [ ] wipfile: Proximity
	 * - [ ] wipfile: Adjuster; drawable.adjuster(true); del key = remove from parent
	 * 
	 * 
	 * - [ ] HText textbox
	 * - [ ] DepthShuffle
	 * - [ ] HVelocity testfiles (check AS3::SimpleBallistic)
	 * - [ ] AS3::Vibration
	 * - [ ] H.capture()
	 * 		- static frame
	 * 		- frame sequence
	 * 		- pdf frames (remember that pdf frames don't ignores autoClear(false))
	 * 
	 * - [ ] HTween: DLOC stuff
	 * 
	 * (Refactors)
	 * - [ ] protected HDrawable.onSizeChange();
	 * - [ ] refactor/cleanup HOscillator
	 * - [ ] use registered() for autoregistering behaviors
	 * - [ ] remove register/unregister overrides
	 * - [ ] privatize remaining public fields
	 * - [ ] standardize boolean getter names
	 * 
	 * (Far Future Stuff)
	 * - [ ] AS3::SoundAnalyzer
	 */
	
	@Override
	public void setup() {
		size(512,512);
		H.init(this);
		
//		/*
		HDrawable d = H.add(new HRect()).locAt(H.CENTER).anchorAt(H.CENTER);
		new HTween().target(d).property(H.Z).ease(random(1/1024f,1)).spring(random(1)).start(0).end(1).callback(new HCallback() {
			public void run(Object obj) {
				HTween t = (HTween) obj;
				t.target().fill(H.RED);
			}
		});
		//*/
		
		H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
		H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
	}
	
	@Override
	public void draw() {
		H.drawStage();
	}
}
