package hype;

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
	
	@Override
	public void setup() {
		size(600,600);
		H.init(this);
		// TODO
	}
	
	@Override
	public void draw() {
		H.drawStage();
	}
}
/** @endcond */