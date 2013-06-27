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
import hype.extended.behavior.HSwarm;
import hype.extended.drawable.HRect;
import hype.extended.util.HDrawablePool;
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
	 * (*)
	 * - [] Iterator testfile
	 * - [ ] property setter objects
	 * 
	 * (Capture)
	 * - HCapture
	 * - post hooks
	 * 
	 * (3D Stuff)
	 * - 3D anchorAt()
	 * 
	 * (HMagneticField)
	 * - BLAHRG
	 * 
	 * (HBehavior)
	 * - [ ] new HBehavior(isRegistered) + isRegistered constructors for other
	 *       behaviors
	 * 
	 * (Bounding Box)
	 * - custom bounds for HPath
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
	 * (Housekeeping)
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
	 * - [ ] Processing.js P3D compatibility
	 * 		- remove push/popStyle()
	 * 		- ???
	 * 
	 * (Future Refactors)
	 * - [ ] have HDrawable perc stuff use x2y()/y2v()/u2x()/v2y()
	 * - [ ] rename xxxPerc -> xxxUV or xxxPc
	 * - [ ] rearrange HDrawable's fields by category instead of type
	 * - [ ] HMath: add z index for abs/relLoc()
	 * - [ ] HMath: use the comparator methods for the bezier methods
	 * - [ ] change util methods that returns arrays to use the method(val, float[] loc) format
	 * - [ ] privatize remaining public fields
	 * - [ ] color mask constants
	 * - [ ] more consistent boolean getter names
	 * - [ ] HDrawable: more consistent fill and stroke color methods
	 * - [ ] separate styling for HDrawable
	 * 
	 * (Code Standards)
	 * - [ ] standardize single param names
	 * - [ ] standardize newlines
	 * 		- newline before & after the class' closing brackets
	 * 		- variable names must never be reserved in both JS and Java
	 * 		- ???
	 * 
	 * (Optimization)
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
	public void setup() {
		size(640,640,P3D);
		H.init(this);
		H.use3D(true);
		H.stage().showsFPS(true);
		
//		HSphere s;
//		H.add(s = new HSphere());
//		s.locAt(H.CENTER).anchorAt(H.CENTER);
		HDrawablePool pool = new HDrawablePool(50)
			.autoAddToStage()
			.add(new HRect())
			.requestAll();
		HSwarm swarm = new HSwarm().addGoal(H.mouse())
				.speed(5)
				.twitch(15)
				.turnEase(.05f);
		for(HDrawable d : pool) {
			d.loc(random(width), random(height)).size(5);
			swarm.addTarget(d);
		}
//		new HTween()
//			.target(H.add(new HRect()).locAt(H.CENTER).anchorAt(H.CENTER))
//			.property(H.ROTATIONY)
//			.start(0).end(45)
//			.ease(.05f).spring(0.9f);
//		new HOscillator()
//			.target(H.add(new HRect()).locAt(H.CENTER).anchorAt(H.CENTER))
//			.property(H.ROTATIONZ)
//			.range(-45, 45);
	}

	public void draw() {
		H.drawStage();
	}
	//*/
}
/** @endcond */