package hype;

import hype.util.H;
import hype.util.HMath;
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
	
	@Override
	public void setup() {
//		size(512,512);
		H.init(this);
		
		float p0 = random(1024);
		float p1 = random(1024);
		float p2 = random(1024);
		float p3 = random(1024);
		float t  = random(1);
		
		float val = bezierPoint(p0,p1,p2,p3,t);
		
		float[] roots = new float[3];
		int numRoots = HMath.bezierParam(p0,p1,p2,p3,val,roots);
		println("root = "+t);
		println("roots:");
		println(roots);
		
		println("\nnum roots: "+numRoots);
		
		println("\nval = "+val);
		println("vals:");
		float[] vals = new float[numRoots];
		for(int i=0; i<numRoots; ++i) vals[i] = bezierPoint(p0,p1,p2,p3,roots[i]);
		println(vals);
		
		exit();//
		/*
		HDrawable d = H.add(new HRect()).locAt(H.CENTER).anchorAt(H.CENTER);
		new HTween().target(d).property(H.SCALE).ease(random(1/1024f,1)).spring(random(1)).start(0).end(1).callback(new HCallback() {
			public void run(Object obj) {
ã				HTween t = (HTween) obj;
				t.target().fill(H.RED);
			}
		});
		
		H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
		H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
		//*/
	}
	
	@Override
	public void draw() {
		//H.drawStage();
		noLoop();
	}
}
/** @endcond */