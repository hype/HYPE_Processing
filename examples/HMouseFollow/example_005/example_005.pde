/* @pjs preload="sintra.jpg"; */

HFollow mf;
HRect d;
HPixelColorist colors;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	PImage img = loadImage("sintra.jpg");
	colors = new HPixelColorist(img)
		.fillOnly()
		// .strokeOnly()
		// .fillAndStroke()
	;

	d = new HRect(100);
	d
		.rounding(40)
		.strokeWeight(2)
		.stroke(#000000, 150)
		.loc(width/2,height/2)
		.anchorAt(H.CENTER)
		.rotation(45)
	;
	H.add(d);

	mf = new HFollow()
		.target(d)
		.ease(0.05)
		.spring(0.95)
	;
}

void draw() {
	colors.applyColor(d);

	H.drawStage();
}

