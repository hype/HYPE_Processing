package hype;

import hype.drawable.HPath;
import hype.drawable.HText;
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
	 * 
	 * - [ ] HShape hit detection
	 * - [ ] use pgraphics buffer for HText
	 * - [ ] child-passable transformations
	 * - [ ] disable style for HShape in P3D
	 * 
	 * - [ ] HDrawable.firstChild(), HDrawable.lastChild();
	 * - [ ] issue #10
	 * - [ ] HMouse flags
	 * 
	 * - [ ] Standardize boolean getters
	 */
	
	@Override
	public void setup() {
		size(1024,768);
		H.init(this);
		
		H.add(new HText("Tux.png")).scale(1,1).locAt(H.CENTER).anchorAt(H.CENTER);
		H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
		H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
	}
	
	@Override
	public void draw() {
		H.drawStage();
		noLoop();//
	}
}
