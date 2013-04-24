package hype;

import hype.drawable.HDrawable;
import hype.drawable.HEllipse;
import hype.layout.HGridLayout;
import hype.util.H;
import processing.core.PApplet;
import processing.core.PVector;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	HDrawable d;
	
	public void setup() {
		size(512,512);
		noLoop();
		H.init(this);
		H.background(H.GREEN);
//		PFont f = createFont("DroidSerifBold.ttf", 16);
//		for(char i='a'; i<'z'; ++i) {
//			PFont.Glyph g = f.getGlyph(i);
//			println(Character.toString(i)+" "+(g.width+g.leftExtent)+", "+round(f.width(i)*16));
//		}
		
		float f = 180+45;//random(-180,360);
		float g = f+350;//f+random(360);
		println(f+", "+g);
		d = H.add(new HEllipse().start(f).end(g).mode(PIE))
//			.scale(random(1,2),random(1,2))
//			.anchorPerc(random(1),random(1))
//			.rotation(random(360))
			.anchorAt(H.CENTER)
			.locAt(H.CENTER);
		
		H.add(new HEllipse()).fill(128).size(4)
			.locAt(H.CENTER).anchorAt(H.CENTER);
	}
	
	public void draw() {
		H.drawStage();
		HGridLayout grid = new HGridLayout(512).spacing(1,1);
		for(int i=0; i<0
//				+1
				+512 * 512
				; ++i) {
			PVector pt = grid.getNextPoint();
			if(d.contains(pt.x, pt.y)) {
				stroke(H.MAGENTA,128);
				point(pt.x,pt.y);
			}
		}
	}
}
