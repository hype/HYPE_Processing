package hype;

import hype.drawable.HPath;
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
	 * - [ ] bezier hitbox for HPath
	 * - [ ] HTween: set _curr = 1, if tweening end is detected
	 * - [ ] HPath: base size for computing perc vertex stuff = 100, if size = 0
	 * 
	 * - [ ] HDrawable.transformChildren(bool)
	 * - [ ] recursive spatial transforms for HDrawable & HGroup
	 * 
	 * (Licensing Stuff)
	 * - [ ] copyright disclaimer for each source file
	 * - [ ] capitalize license.txt and changelog.md
	 * 
	 * - [ ] pointInScreen(x,y,z)
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
	 * - [ ] quadratic HVertex
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
	
	HPath path;
	
	@Override
	public void setup() {
		size(600,600);
		H.init(this);
		
		path = new HPath(POLYGON)
//			.vertexPerc(-.5f,.5f,.5f,.5f,0,0)
//			.vertexPerc(.5f,-.5f,.5f,.5f,1,0)
//			.vertexPerc(1.5f,.5f,.5f,.5f,1,1)
//			.vertexPerc(.5f,1.5f,.5f,.5f,0,1)
			.vertexPerc(0,0)
			.vertexPerc(1,0)
			.vertexPerc(1,1)
			.vertexPerc(2/3f,1)
			.vertexPerc(2/3f,2/3f,1/3f,1/3f,0,1/3f)
//			.star(5,H.PHI_1)
//			.polygon(5)
		;
		H.add(path).locAt(H.CENTER).anchorAt(H.CENTER);
	}
	
	@Override
	public void draw() {
		H.drawStage();
//		if(path.contains(mouseX,mouseY)) {
//			path.fill(H.RED);
//		} else {
//			path.fill(H.WHITE);
//		}
		stroke(H.MAGENTA,128);
		for(int y=0;y<height;++y) for(int x=0;x<width;++x) {
			if(path.contains(x,y)) {
				point(x,y);
			}
		}
		noLoop();
	}
}
/** @endcond */