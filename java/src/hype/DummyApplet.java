package hype;

import hype.behavior.HTween;
import hype.drawable.HDrawable;
import hype.drawable.HPath;
import hype.drawable.HRect;
import hype.interfaces.HCallback;
import hype.util.H;
import hype.util.HColors;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	/* TODO
	 * - [ ] fix random color bug
	 * - [ ] base size for computing perc stuff = 0, if size = 0
	 * 	- [ ] anchor
	 * 	- [ ] vertex
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
	 * - [ ] protected HDrawable.onSizeChange();
	 * - [ ] refactor/cleanup HOscillator
	 * 
	 * - [ ] HTween refinements
	 * - [ ] AS3::SoundAnalyzer
	 * - [ ] Standardize boolean getters
	 */
	
	@Override
	public void setup() {
		size(512,512);
		H.init(this);
		
		int clr = HColors.merge(-512,-512,-412,-512);
		println(hex(HColors.merge(-512,-512,-412,-512)));
		println(hex(HColors.setBlue(clr, -512)));
		
		HDrawable d = H.add(new HRect()).locAt(H.BOTTOM_RIGHT).move(-64,-64);
		new HTween().target(d).property(H.LOCATION).ease(.01f).spring(0.9f).start(width,height).end(width/2,height/2).callback(new HCallback() {
			
			@Override
			public void run(Object obj) {
				System.out.println("Hey");
			}
		});
		H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
		H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
	}
	
	@Override
	public void draw() {
		H.drawStage();
	}
}
