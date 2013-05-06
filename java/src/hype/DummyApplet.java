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
	 * - [ ] Z-axis on HDrawable
	 * 
	 * - [ ] flipping via width() & height() / allow negative width & height
	 * 	- [x] HImage
	 * 	- [x] HPath
	 * 	- [ ] HShape
	 * 	- [ ] HText
	 * - [ ] HDrawable.firstChild(), HDrawable.lastChild();
	 * - [ ] HMouse flags
	 * 
	 * - [ ] Standardize boolean getters
	 */
	
	@Override
	public void setup() {
		size(512,512);
		H.init(this);
		
		H.add(new HImage("Tux.png")).scale(1,1).locAt(H.CENTER).anchorAt(H.CENTER);
//		H.add(new HPath().vertexPerc(0,0).vertexPerc(1,0).vertexPerc(0,1)).locAt(H.CENTER).width(64).height(64).strokeWeight(2);
//		H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
//		H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
	}
	
	@Override
	public void draw() {
		H.drawStage();
		
//		PImage img = loadImage("Tux.png");
		noLoop();//
	}
}
