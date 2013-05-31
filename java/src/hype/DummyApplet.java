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

import hype.drawable.HDrawable;
import hype.drawable.HPathNEW;
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
	 * (new HVertices)
	 * - [ ] fix HVertexNEW and HPathNEW's hitbox
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
	 * - [ ] H.add() for each drawable type
	 * 
	 * (Refactors)
	 * - [ ] have HDrawable perc stuff use x2pc()/y2pc()/x2px()/y2px()
	 * - [ ] rename xxxPerc -> xxxUV
	 * - [ ] rearrange HDrawable's fields by category
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
		size(600,600);
		H.init(this);
		H.background(H.BLUE);
		
		HDrawable d = H.add(new HPathNEW(POLYGON)
			.vertex(-25f, 50f, 25f, 50f, 0,0)
			.vertex( 50f,-25f, 50f, 25f, 100,0)
			.vertex(125f, 50f, 75f, 50f, 100,100)
//			.vertex(0,0)
//			.vertex(100,0)
//			.vertex(100,100)
//			.vertex(0,100)
			.endPath()
		).locAt(H.CENTER).stroke(H.WHITE).strokeWeight(3).fill(0xFFC0FFEE);
		
		H.drawStage();
		stroke(H.RED,192);
		for(int y=0; y<height; ++y) for(int x=0; x<width; ++x) {
			if(d.contains(x,y)) {
				point(x,y);
			}
		}
		noLoop();
	}
}
/** @endcond */