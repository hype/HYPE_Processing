package hype;

import hype.behavior.HTween;
import hype.drawable.HDrawable;
import hype.drawable.HPath;
import hype.drawable.HRect;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	/* TODO
	 * - [x] HDrawable.proportional()
	 * - [x] remove HPath.preserveSizeRatio()
	 * - [x] HMouse._started tweaks
	 * - [x] Z-axis on HDrawable
	 * - [x] HDrawable.paintAll( ... boolean usesZ )
	 * - [x] HCanvas.graphics()
	 * - [x] flipping via width() & height() / allow negative width & height
	 * 	- [x] HImage
	 * 	- [x] HPath
	 * 	- [x] HShape
	 * 	- [x] HText
	 * - [x] Z-axis on HSwarm & HLocatable
	 * - [x] Renderers for HCanvas
	 * - [x] Pre-clear the _graphics in HCanvas
	 * - [x] Call loadPixels on hasFade
	 * - [x] HBundle shortcuts for HDrawable
	 * - [x] HTween
	 * 
	 * - [ ] pointInScreen
	 * - [ ] HShape hit detection + pgraphics buffer
	 * - [ ] use pgraphics buffer for HText
	 * - [ ] child-passable transformations
	 * - [ ] disable style for HShape in P3D
	 * 
	 * - [ ] HDrawable.firstChild(), HDrawable.lastChild();
	 * - [ ] issue #10 (make HVector a PVector container instead of subclass)
	 * - [ ] HMouse flags
	 * - [ ] protected HDrawable.onSizeChange();
	 * - [ ] migration of math calls to java.lang.Math
	 * - [ ] privatize fields for non-subclassed classes
	 * - [ ] refactor HOscillator
	 * - [ ] negative ease on everything
	 * 
	 * - [ ] Standardize boolean getters
	 */
	
	@Override
	public void setup() {
		size(512,512);
		H.init(this);
		
		HDrawable d = H.add(new HRect()).locAt(H.BOTTOM_RIGHT).move(-64,-64);
		new HTween().target(d).property(H.LOCATION).ease(.05f).spring(.9f).start(width,height).end(width/2,height/2);
		H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
		H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
	}
	
	@Override
	public void draw() {
		H.drawStage();
	}
}
