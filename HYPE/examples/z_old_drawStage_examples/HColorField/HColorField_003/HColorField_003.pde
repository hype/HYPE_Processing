import hype.*;
import hype.extended.colorist.HColorField;
import hype.extended.behavior.HFollow;
import hype.extended.behavior.HOscillator;

HFollow     mf;
HRect       rect;
HColorField colorField;

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(false);

	colorField = new HColorField(width, height)
		.addPoint(0, height/2, #FF0066, 0.5f)
		.addPoint(width, height/2, #3300FF, 0.5f)
		.fillOnly()
		// .strokeOnly()
		// .fillAndStroke()
	;

	rect = new HRect(100);
	rect.rounding(40).strokeWeight(2).stroke(0, 150).fill(0).loc(width/2,height/2).anchorAt(H.CENTER).rotation(45);
	H.add(rect);

	mf = new HFollow().target(rect).ease(0.05).spring(0.95);
	new HOscillator().target(rect).property(H.SIZE).range(10, 100).speed(1).freq(4);
}

void draw() {
	rect.fill(0).anchorAt(H.CENTER);
	colorField.applyColor(rect);

	H.drawStage();
}

