package hype;

import hype.drawable.HPath;
import hype.drawable.HRect;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;
	
	private HPath path;
	
	@SuppressWarnings("static-access")
	public void setup() {
		size(640,640);
		noLoop();
		H.init(this).background(0xFF88FF);
		
//		H.add(new HRect(100)).locAt(H.CENTER).anchorAt(H.CENTER).fill(0,255,0,128);
//		H.add(new HEllipse(50)).locAt(H.CENTER).anchorAt(H.CENTER).stroke(0,0,0,128);
		
		H.add(new HRect(100)).locAt(H.CENTER).anchorAt(H.BOTTOM|H.RIGHT).fill(0,255,0,128);
		H.add(new HRect(100)).locAt(H.CENTER).fill(0,255,0,128);
		
		path = new HPath(POLYGON);
		H.add(path)
			.fill(255,255,255,64).stroke(0,64)
			.loc(width/2, height/2)
			.strokeWeight(2)
			.strokeJoin(ROUND);
		
		path
			.vertex(-25,-25)
			.vertex(25,-25)
			.vertex(25,25)
			.vertex(-25,25)
		.adjustVertices();
		
		println(path.size());
		println(path.anchorPerc());
//		println(path.loc());
	}

	public void draw() {
		H.drawStage();
	}
}
