package hype;

import hype.drawable.HImage;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	/*
	 * TODO
	 * - [x] HDrawable.proportional()
	 * - [x] remove HPath.preserveSizeRatio()
	 * - [x] HMouse._started tweaks
	 * 
	 * - flipping via width() & height() / allow negative width & height
	 * 	- [ ] HImage
	 * 	- [ ] HEllipse
	 * 	- [ ] HPath
	 * 	- [ ] HShape
	 * 	- [ ] HText
	 * 
	 * - [ ] HDrawable.firstChild(), HDrawable.lastChild();
	 * - [ ] HMouse flags
	 */
	
	@Override
	public void setup() {
		size(512,512);
		H.init(this);
		
		H.add(new HImage("Tux.png")).scale(1,-.75f).locAt(H.CENTER).anchorAt(H.CENTER);
	}
	
	@Override
	public void draw() {
		H.drawStage();
		noLoop();//
	}
}
