import hype.*;
import hype.extended.colorist.HColorField;
import hype.extended.behavior.HFollow;

HFollow     mf;
HRect       rect;
HColorField colorField;

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(false);

	colorField = new HColorField(width, height)
		.addPoint(0,     height/2, #FF0066, 0.5f)
		.addPoint(width, height/2, #3300FF, 0.5f)
		.fillOnly()
		// .strokeOnly()
		// .fillAndStroke()
	;

	rect = new HRect(100);
	rect.rounding(40).strokeWeight(2).stroke(0, 150).fill(#000000).loc(width/2,height/2).anchorAt(H.CENTER).rotation(45);
	H.add(rect);

	mf = new HFollow().target(rect).ease(0.05).spring(0.95);
}

void draw() {
	rect.fill(#000000, 225);
	colorField.applyColor(rect);

	H.drawStage();
}
