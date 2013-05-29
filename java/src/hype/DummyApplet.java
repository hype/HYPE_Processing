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

import hype.behavior.HTween;
import hype.colorist.HColorPool;
import hype.drawable.HDrawable;
import hype.drawable.HRect;
import hype.drawable.HShape;
import hype.interfaces.HCallback;
import hype.trigger.HTimer;
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
	 * - [ ] HPath: base size for computing perc vertex stuff = 100, if size = 0
	 * 
	 * - [ ] add z index for abs/relLoc()
	 * 
	 * - [ ] HDrawable.transformChildren(bool)
	 * - [ ] recursive spatial transforms for HDrawable & HGroup
	 * - [ ] HHittable.contains(x,y,z)
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
		//frameRate(6);
		H.init(this);
		H.background(64);
		
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
		
		HDrawable d = H.add(new HRect());
		final HTween t = new HTween();
		t.property(H.SCALE).target(d).start(0).end(1).ease(.03f).spring(.9f).callback(new HCallback(){public void run(Object o) {
			new HTimer(1000,1).callback(new HCallback(){public void run(Object obj) {
				t.start(1).end(0).spring(0).ease(.03f).register();
			}});
		}});
	}
	
	@Override
	public void draw() {
		H.drawStage();
		//s4.randomColors(colors);
	}
}
/** @endcond */