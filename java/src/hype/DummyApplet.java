package hype;

import hype.colorist.HColorPool;
import hype.drawable.HShape;
import hype.util.H;
import processing.core.PApplet;

/**
 * @mainpage
 * Welcome to the HYPE_processing documentation! The library itself is currently
 * under construction, so naturally, the documentation is far from complete yet.
 * 
 * @cond FALSE
 */
public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	/* TODO
	 * - [ ] static random colors for HShape
	 * - [ ] HPath: base size for computing perc vertex stuff = 100, if size = 0
	 * 
	 * - [ ] HDrawable.transformChildren(bool)
	 * - [ ] recursive spatial transforms for HDrawable & HGroup
	 * - [ ] HHittable.contains(x,y,z)
	 * 
	 * (Licensing Stuff)
	 * - [ ] copyright disclaimer for each source file
	 * 
	 * - [ ] HShape hit detection + pgraphics buffer
	 * - [ ] disable style for HShape in P3D
	 * - [ ] use pgraphics buffer for HText + use that for hitbox checking
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
	 * 		- capture() -- current frame
	 * 		- capture(1) -- single frame
	 * 		- capture(1,10) -- frame sequence
	 * 		- pdf frames (remember that individual pdf frames ignores autoClear(false))
	 * 
	 * - [ ] HTween: DLOC stuff
	 * 
	 * 
	 * (Refactors)
	 * - [ ] use float arrays instead of HVertex
	 * - [ ] bezierParam() for quadratic curves
	 * - [ ] HMath: use processing's random()
	 * - [ ] HMath: change "arr" methods to use method(val, float[] loc) format
	 * - [ ] protected HDrawable.onSizeChange();
	 * - [ ] refactor/cleanup HOscillator
	 * - [ ] use registered() for autoregistering behaviors
	 * - [ ] remove register/unregister overrides
	 * - [ ] privatize remaining public fields
	 * - [ ] standardize boolean getter names
	 * 
	 * (Far Future Stuff)
	 * - [ ] AS3::SoundAnalyzer
	 * - [ ] HContext overhaul
	 */
	
	HShape s1,s2,s3,s4;
	HColorPool colors;
	
	@Override
	public void setup() {
		size(600,600);
		frameRate(6);
		H.init(this).background(64);
		
		colors = new HColorPool(
			0xFFFFFFFF, 0xFFF7F7F7, 0xFFECECEC, 0xFF333333,
			0xFF0095A8, 0xFF00616F, 0xFFFF3300, 0xFFFF6600);
		
		s1 = new HShape("bot1.svg");
		H.add(s1).scale(0.5f);
		
		s2 = new HShape("bot1.svg");
		H.add(s2).scale(0.5f).anchorAt(H.CENTER).locAt(H.CENTER);
		
		s3 = new HShape("bot1.svg");
		H.add(s3).scale(0.5f).anchorAt(H.BOTTOM_RIGHT).locAt(H.BOTTOM_RIGHT);
		
		s4 = new HShape("bot1.svg");
		H.add(s4).scale(0.5f).anchorAt(H.BOTTOM_LEFT).locAt(H.BOTTOM_LEFT);
		
		
		colors.fillOnly();
		s1.randomColors(colors);
		
		colors.strokeOnly();
		s2.randomColors(colors);
		
		colors.fillAndStroke();
		s3.randomColors(colors);
	}
	
	@Override
	public void draw() {
		H.drawStage();
		s4.randomColors(colors);
	}
}
/** @endcond */