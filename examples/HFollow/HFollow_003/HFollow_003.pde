import hype.*;
import hype.extended.behavior.HFollow;

HFollow mf;
HRect   rect;

void setup() {
	size(640,640);
	H.init(this).background(#242424);
	
	rect = new HRect(100);
	rect.rounding(40).noStroke().fill(#ECECEC).loc(width/2,height/2).anchorAt(H.CENTER).rotation(45);
	H.add(rect);

	// HFollow / ease and spring

	mf = new HFollow().target(rect).ease(0.1).spring(0.95);
}

void draw() {
	H.drawStage();
}
