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

import hype.core.util.H;
import hype.extended.drawable.HRect;
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
	 * - [ ] remove old oscillator_overhaul branch
	 * - [ ] Testfile for HDrawable.transformsChildren()
	 * 
	 * (HPath)
	 * - [ ] fix HVertexNEW and HPathNEW's hitbox
	 * - [ ] HPathNEW.line(x,y,x,y);
	 * 
	 * (HDrawable)
	 * - [ ] HDrawable.styleChildren(bool)
	 * - [ ] HDrawable.rotatesChildren(bool)
	 * - [ ] recursive spatial transforms for HDrawable
	 * 		- location
	 * 		- size
	 * - [ ] recursive style transforms for HDrawable
	 * 		- stroke
	 * 		- stroke weight
	 * 		- stroke join
	 * 		- stroke cap
	 * 		- fill
	 * - [ ] apply the UV stuff
	 * 
	 * (HBehavior)
	 * - [ ] boolean params for HBehavior constructors (default=true, true - register, false don't register)
	 * - [ ] HTween: start/end 1/2/3 getters
	 * - [ ] HTween: delegate start() & end() methods to start(a,b,c) & start(a,b,c)
	 * - [ ] new HBehavior(isRegistered) + isRegistered constructors for other behaviors
	 * - [ ] HTween & HOscillator: store the scale factor when using H.SCALE instead
	 *       of the multiplied sizes; just compute the "multiplier" in runBehavior()
	 *       to multiply the curent values (in this case, width and height)
	 * 
	 * (HShape)
	 * - [ ] HShape hit detection + pgraphics buffer
	 * - [ ] disable style for HShape in P3D
	 * 
	 * (HText)
	 * - [ ] click buffer for HText
	 * - [ ] textbox mode for HText
	 * - [ ] use onResize() when adjusting metrics
	 * 
	 * (HCallback NOP)
	 * - HConstants.NOP (an empty HCallback that does nothing, to be used as
	 *   sentinel; test this on JS mode)
	 * - HDrawablePool
	 * 		- Replace HCallback null checks with NOP
	 * 		- if onCreate/Request/Release(null), then assign NOP
	 * 		- privatize _onCreate/Request/Release
	 * - HTriggers & HTween
	 * 		- Replace HCallback null checks with NOP
	 * 		- if callback(null), then assign NOP
	 * 
	 * (HRect)
	 * - [ ] rounding() getter (returns _tl)
	 * - [ ] privatize _tl/_tr/_br/_bl fields
	 * 
	 * 
	 * (Experiments and New Features)
	 * - [ ] new interface: HImageHolder
	 * 		- interface methods: image(Object imgArg), image()
	 * 		- H.extractImage(Object imgArg)
	 * 			- if arg is PImage: use the image
	 * 			- if arg is HImageHolder: call image()
	 * 			- if arg is String: load file
	 * 			- else: return null
	 * 		- implement this to HImage and HPixelColorist and HStage (for img bg)
	 * 		- apply when setting images
	 * - [ ] masking
	 * - [ ] wipfile: Proximity
	 * - [ ] wipfile: Adjuster
	 * 		- drawable.adjuster(true)
	 * 		- del key = remove from parent
	 * - [ ] DepthShuffle
	 * - [ ] HVelocity testfiles (check AS3::SimpleBallistic)
	 * - [ ] AS3::Vibration
	 * - [ ] H.capture()
	 * 		- capture() -- current frame
	 * 		- capture(1) -- single frame
	 * 		- capture(1,10) -- frame sequence
	 * 		- pdf frames (remember that individual pdf frames ignores autoClear(false))
	 * - [ ] store HDrawable coordinates as UV
	 * 
	 * (Future Refactors)
	 * - [ ] property setter objects
	 * - [ ] have HColors implement HConstants
	 * - [ ] have HDrawable perc stuff use x2y()/y2v()/u2x()/v2y()
	 * - [ ] rename xxxPerc -> xxxUV or xxxPc
	 * - [ ] rearrange HDrawable's fields by category
	 * - [ ] bezierParam() for quadratic curves
	 * - [ ] HMath: add z index for abs/relLoc()
	 * - [ ] HMath: use processing's random()
	 * - [ ] change util methods that returns arrays to use the method(val, float[] loc) format
	 * - [ ] privatize remaining public fields
	 * - [ ] standardize boolean getter names
	 * - [ ] color mask constants
	 * - [ ] HColors.invisible() -- use color masks `(clr & maskAlpha) == 0`
	 * 
	 * (Docs)
	 * - [ ] use full sentence format with @param and @return statements
	 * - [ ] use multiple @see tags
	 * - [ ] use a single line break for doc summaries if they're too long
	 * 
	 * (Far Future Stuff)
	 * - [ ] HContext overhaul
	 * - [ ] FSM java to pde parser
	 * - [ ] HYPE Coding Standards documentation for devs
	 * - [ ] HTML Page for the Documentation
	 * - [ ] AS3::SoundAnalyzer
	 */
	
	@Override
	public void setup() {
		size(600,600);
		H.init(this);
		H.background(H.BLUE);
		
		HRect rect = H.add(new HRect()).rounding(10);
		rect.add(new HRect(10)).locAt(H.TOP_LEFT).alpha(128);
		rect.add(new HRect(10)).locAt(H.TOP_RIGHT).alpha(128);
		rect.add(new HRect(10)).locAt(H.BOTTOM_RIGHT).alpha(128);
		rect.add(new HRect(10)).locAt(H.BOTTOM_LEFT).alpha(128);
		rect.add(new HRect(10)).locAt(H.CENTER).alpha(128);
		rect.transformsChildren(true);
		rect.size(200,200);
		
//		HDrawable d = H.add(new HPathNEW(POLYGON)
//			.vertex(-25f, 50f, 25f, 50f, 0,0)
//			.vertex( 50f,-25f, 50f, 25f, 100,0)
//			.vertex(125f, 50f, 75f, 50f, 100,100)
////			.vertex(0,0)
////			.vertex(100,0)
////			.vertex(100,100)
////			.vertex(0,100)
//			.endPath()
//		).locAt(H.CENTER).stroke(H.WHITE).strokeWeight(3).fill(0xFFC0FFEE);
//		
//		H.drawStage();
//		stroke(H.RED,192);
//		for(int y=0; y<height; ++y) for(int x=0; x<width; ++x) {
//			if(d.contains(x,y)) {
//				point(x,y);
//			}
//		}
//		noLoop();
	}
	
	@Override
	public void draw() {
		H.drawStage();
	}
}
/** @endcond */