import hype.*;
import hype.extended.colorist.HPixelColorist;
import hype.extended.behavior.HFollow;

HPixelColorist colors;
HFollow        mf;
HRect          rect;

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(false);

	colors = new HPixelColorist("sintra.jpg").fillOnly();
	
	rect = new HRect(100);
	rect.rounding(40).strokeWeight(2).stroke(0,150).loc(width/2,height/2).anchorAt(H.CENTER).rotation(45);
	H.add(rect);

	mf = new HFollow().target(rect).ease(0.05).spring(0.95);
}

void draw() {
	colors.applyColor(rect);
	H.drawStage();
}
