import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HFollow;

HColorPool colors;
HFollow    mf;
HRect      rect;

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(false);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);
	
	rect = new HRect(100);
	rect.rounding(40).strokeWeight(2).fill(#111111).loc(width/2,height/2).anchorAt(H.CENTER).rotation(45);
	H.add(rect);

	mf = new HFollow().target(rect).ease(0.05).spring(0.95);
}

void draw() {
	rect.stroke( colors.getColor() );
	H.drawStage();
}
