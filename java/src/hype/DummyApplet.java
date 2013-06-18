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
import hype.extended.behavior.HFollow;
import hype.extended.behavior.HRotate;
import hype.extended.drawable.HRect;
import processing.core.PApplet;
import processing.core.PVector;

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
	 * - HMagneticField stuff
	 * 
	 * (HBehavior)
	 * - [ ] new HBehavior(isRegistered) + isRegistered constructors for other
	 *       behaviors
	 * - [ ] HTween & HOscillator: store the scale factor when using H.SCALE
	 *       instead of the multiplied sizes; just compute the "multiplier" in
	 *       runBehavior() to multiply the curent values (in this case, width
	 *       and height)
	 * 
	 * (HPath)
	 * - [ ] apply tolerance to HVertex.intersectTest()
	 * - [ ] testfile for HPath
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
	 * 
	 * (Github Housekeeping)
	 * - [ ] announce deprecation warning at github
	 * 
	 * (Experiments and New Features)
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
	 * - [ ] HDrawable / HLinkedList: turn them into circular linked lists
	 * 
	 * (Future Refactors)
	 * - [ ] property setter objects
	 * - [ ] have HDrawable perc stuff use x2y()/y2v()/u2x()/v2y()
	 * - [ ] rename xxxPerc -> xxxUV or xxxPc
	 * - [ ] rearrange HDrawable's fields by category instead of type
	 * - [ ] HMath: add z index for abs/relLoc()
	 * - [ ] HMath: use processing's random() instead of java.lang.Math's
	 * - [ ] HMath: replace round512() with the tolerance comparators
	 * - [ ] HMath: use the comparator methods for the bezier methods
	 * - [ ] change util methods that returns arrays to use the method(val, float[] loc) format
	 * - [ ] privatize remaining public fields
	 * - [ ] color mask constants
	 * - [ ] more consistent boolean getter names
	 * - [ ] HDrawable: more consistent fill and stroke color methods
	 * 
	 * (Code Standards)
	 * - [ ] standardize single param names
	 * - [ ] standardize newlines
	 * 		- newline before & after the class' closing brackets
	 * 		- variable names must never be reserved in both JS and Java
	 * 		- ???
	 * 
	 * (Optimization)
	 * - [ ] use bitflags for multiple bools
	 * - [ ] use byte for small ints
	 * 
	 * (Docs)
	 * - [ ] migrate to standard javadoc (?)
	 * - [ ] use full sentence format with @param and @return statements
	 * - [ ] one @see tag per link
	 * - [ ] use a single line break for doc summaries if they're too long
	 * - [ ] use the `[`,`]`,`(`,`)` brackets to depict a range of values
	 *       (parentheses means that the lower or upper bounds are exclusive,
	 *       while square brackets means inclusive)
	 * 
	 * (Far Future Stuff)
	 * - [ ] Standards compliant SVG parser to convert a shape to a Path
	 * - [ ] HContext overhaul
	 * - [ ] FSM java to pde parser
	 * - [ ] HYPE Coding Standards documentation for devs
	 * - [ ] HTML Page for the Documentation
	 * - [ ] AS3::SoundAnalyzer
	 */
	
	//*/
	HRect r1, r2;
	
	public void setup() {
		size(640,640);
		H.init(this);
		
		H.add(r2 = new HRect()).fill(H.GREEN);
		H.add(r1 = new HRect()).anchorAt(H.CENTER).locAt(H.CENTER);
		
		new HRotate().target(r1).speed(1);
		new HFollow().target(r1);
	}

	public void draw() {
		PVector loc = new PVector();
		PVector size = new PVector();
		r1.bounds(loc, size);
		r2.loc(loc).size(size.x,size.y);
		fill(0);
		H.drawStage();
		text(frameRate, 0, 16);
	}
	//*/
}
/** @endcond */