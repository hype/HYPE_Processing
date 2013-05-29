/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

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
	 * - [ ] new class: HVertex
	 * - [ ] HPath: base size for computing perc vertex stuff = 100, if size = 0
	 * - [ ] HPath: include the vertice's ctrl points
	 * - [ ] HMath.bezierParam() for quadratic curves
	 * 
	 * - [ ] HDrawable.transformChildren(bool)
	 * - [ ] recursive spatial transforms for HDrawable
	 * 		- size
	 * 		- anchor
	 * - [ ] recursive style transforms for HDrawable
	 * 		- stroke
	 * 		- stroke weight
	 * 		- stroke join
	 * 		- stroke cap
	 * 		- fill
	 * - [ ] protected HDrawable.onSizeChange();
	 * 
	 * - [ ] HShape hit detection + pgraphics buffer
	 * - [ ] disable style for HShape in P3D
	 * - [ ] use pgraphics buffer for HText + use that for hitbox checking
	 * 
	 * - [ ] masking
	 * - [ ] wipfile: Proximity
	 * - [ ] wipfile: Adjuster; drawable.adjuster(true); del key = remove from parent
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
	 * (Refactors)
	 * - [ ] rearrange HDrawable's fields
	 * - [ ] bezierParam() for quadratic curves
	 * - [ ] HMath: add z index for abs/relLoc()
	 * - [ ] HMath: use processing's random()
	 * - [ ] HMath: change "arr" methods to use method(val, float[] loc) format
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
		H.init(this);
		
		float p0 = random(1024);
		float p1 = random(1024);
		float p2 = random(1024);
		float t  = random(1);
		float val = quadratic(p0,p1,p2,t);
		
		float[] params = new float[2];
		int numParams = HMath.bezierParam(p0,p1,p2,val,params);
		println("t:  "+t);
		println(params);
		println("num: "+numParams);
		
		float[] vals = new float[2];
		for(int i=0; i<2; ++i) vals[i] = quadratic(p0,p1,p2,params[i]);
		println("val:"+val);
		println(vals);
		
		exit();
	}
	
	float quadratic(float p0, float p1, float p2, float t) {
		float a = p2 - 2*p1 + p0;
		float b = 2 * (p1-p0);
		float c = p0;
		float tt = t*t;
		return a*tt + b*t + c;
	}
}
/** @endcond */