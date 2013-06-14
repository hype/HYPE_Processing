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

import hype.core.drawable.HDrawable;
import hype.core.util.H;
import hype.extended.behavior.HRotate;
import hype.extended.drawable.HGroup;
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
	 * (HDrawable)
	 * - [ ] remove casting reqs for add() / remove()
	 * 
	 * (HPath)
	 * - [ ] apply tolerance to HVertexNEW.intersectTest()
	 * - [ ] testfile for HPath
	 * 
	 * (HBehavior)
	 * - [ ] boolean params for HBehavior constructors (default=true,
	 *       true - register, false - don't register)
	 * - [ ] HTween: start/end 1/2/3 getters
	 * - [ ] HTween: delegate start() & end() methods to start(a,b,c) &
	 *       start(a,b,c)
	 * - [ ] new HBehavior(isRegistered) + isRegistered constructors for other
	 *       behaviors
	 * - [ ] HTween & HOscillator: store the scale factor when using H.SCALE
	 *       instead of the multiplied sizes; just compute the "multiplier" in
	 *       runBehavior() to multiply the curent values (in this case, width
	 *       and height)
	 * - [ ] remove `registered()`
	 * - [ ] abstract `HBehavior.createCopy()`
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
	 * - [ ] store HDrawable coordinates as UV
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
	 * - [ ] HDrawable / HLinkedList: turn them into circular linked lists
	 * 
	 * (Misc)
	 * - Nicer README.md
	 * 
	 * (Future Refactors)
	 * - [ ] property setter objects
	 * - [ ] have HColors implement HConstants
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
	 * - [ ] use full sentence format with @param and @return statements
	 * - [ ] use multiple @see tags
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
	
	//*
	public void setup() {
		size(600,600);
		H.init(this);

		HDrawable r = new HRect(20).rounding(2).anchorAt(H.CENTER);

		HDrawable d1 = H.add(new HRect(50).rounding(4)).anchorAt(H.CENTER).loc(width/5,height/2);
		d1.add(r.createCopy()).locAt(H.TOP_LEFT);
		d1.add(r.createCopy()).locAt(H.BOTTOM_RIGHT);

		HDrawable d2 = H.add(new HRect(50).rounding(4)).anchorAt(H.CENTER).loc(width*2/5,height/2);
		d2.add(r.createCopy()).locAt(H.TOP_LEFT);
		d2.add(r.createCopy()).locAt(H.BOTTOM_RIGHT);

		HDrawable grp1 = H.add(new HGroup()).size(50).anchorAt(H.CENTER).loc(width*3/5,height/2);
		grp1.add(r.createCopy()).locAt(H.TOP_LEFT);
		grp1.add(r.createCopy()).locAt(H.BOTTOM_RIGHT);

		HDrawable grp2 = H.add(new HGroup()).size(50).anchorAt(H.CENTER).loc(width*4/5,height/2);
		grp2.add(r.createCopy()).locAt(H.TOP_LEFT);
		grp2.add(r.createCopy()).locAt(H.BOTTOM_RIGHT);

		d2.rotatesChildren(true);
		grp2.rotatesChildren(true);

		new HRotate(d1, 1);
		new HRotate(d2, 1);
		new HRotate(grp1, 1);
		new HRotate(grp2, 1);
	}

	public void draw() {
		H.drawStage();
	}
	//*/
}
/** @endcond */