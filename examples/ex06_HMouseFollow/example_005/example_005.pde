// As seen here, we need to preload Images and Fonts.
//
// See http://processingjs.org/reference/preload/
// and http://processingjs.org/reference/font/
// for more information.

/*
@pjs preload="sintra.jpg";
*/

HFollow mf;
HRect rect;
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

	rect = new HRect(100);
	rect.rounding(40)
		.strokeWeight(2)
		.stroke(#000000, 150)
		.loc(width/2,height/2)
		.anchorAt(H.CENTER)
		.rotation(45);
	H.add(rect);

	mf = new HFollow()
		.target(rect)
		.ease(0.05)
		.spring(0.95)
	;
}

void draw() {
	colors.applyColor(rect);

	H.drawStage();
}