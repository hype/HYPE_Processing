package hype;

import hype.behavior.HFollow;
import hype.drawable.HEllipse;
import hype.util.H;
import processing.core.PApplet;

public class DummyApplet extends PApplet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("static-access")
	@Override
	public void setup() {
		size(1024,512);
		H.init(this).background(H.WHITE);
		
		new HFollow(.05f,.9f).target(H.add(new HEllipse()).locAt(H.CENTER).anchorAt(H.CENTER));
	}
	
	@Override
	public void draw() {
		H.drawStage();
	}
}
