package hype;

import hype.behavior.HTween;
import hype.drawable.HDrawable;
import hype.drawable.HPath;
import hype.drawable.HRect;
import hype.interfaces.HCallback;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	/* TODO
	 * - [ ] 2d point from 3d
	 * 
	 * - [ ] HShape hit detection + pgraphics buffer
	 * - [ ] use pgraphics buffer for HText
	 * - [ ] bezier stuff for HPath
	 * 
	 * - [ ] masking
	 * - [ ] Proximity
	 * - [ ] Adjuster
	 * 	- drawable.adjuster(true)
	 * 	- move on drag
	 * 	- delete = remove from parent
	 * 
	 * - [ ] recursive spatial transforms HDrawable
	 * - [ ] recursive stuff for HGroup / child-passable transformations
	 * 
	 * - [ ] DepthShuffle
	 * - [ ] H.capture(<input event>, <filename>) capture static frame
	 * - [ ] H.capture(<start>,<end>,<filename>) capture sequence of frames
	 * - [ ] capture pdf (keep copies when moving for the pdf export OR keep a record of past transforms)
	 * - [ ] HVelocity examples (check AS3::SimpleBallistic)
	 * - [ ] check AS3::Vibration classes
	 * 
	 * - [ ] disable style for HShape in P3D
	 * 
	 * - [ ] HDrawable.firstChild(), HDrawable.lastChild();
	 * - [ ] issue #10 (make HVector a PVector container instead of subclass)
	 * - [ ] HMouse flags
	 * - [ ] protected HDrawable.onSizeChange();
	 * - [ ] migration of math calls to java.lang.Math
	 * - [ ] privatize fields for non-subclassed classes
	 * - [ ] refactor HOscillator
	 * - [ ] negative ease on stuff
	 * - [ ] use int ratios instead of float for HTween
	 * 
	 * - [ ] AS3::SoundAnalyzer
	 * - [ ] Standardize boolean getters
	 */
	
	@Override
	public void setup() {
		size(512,512);
		H.init(this);
		
		HDrawable d = H.add(new HRect()).locAt(H.BOTTOM_RIGHT).move(-64,-64);
		new HTween().target(d).property(H.LOCATION).ease(.01f).spring(0.9f).start(width,height).end(width/2,height/2).callback(new HCallback() {
			
			@Override
			public void run(Object obj) {
				System.out.println("Hey");
			}
		});
		H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
		H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
	}
	
	@Override
	public void draw() {
		H.drawStage();
	}
}
