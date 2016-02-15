import hype.*;
import hype.extended.colorist.HPixelColorist;
import hype.extended.colorist.HColorTransform;

int     numAssets = 660;
int     xStart    = 20;
int     yStart    = 50;
int     xSpacing  = 10;
int     ySpacing  = 50;
int     numCols   = 60;
HRect[] rects     = new HRect[numAssets];

HPixelColorist  colors;
HColorTransform ct01, ct02, ct03, ct04, ct05, ct06, ct07, ct08, ct09, ct10, ct11;

void setup() {
	size(640,640);
	PImage bg = loadImage("sintra.jpg");
	H.init(this).background(#242424).backgroundImg(bg);

	colors = new HPixelColorist(bg).fillOnly();

	ct01 = new HColorTransform().fillOnly();
	ct02 = new HColorTransform().fillOnly();
	ct03 = new HColorTransform().fillOnly();
	ct04 = new HColorTransform().fillOnly();
	ct05 = new HColorTransform().fillOnly();
	ct06 = new HColorTransform().fillOnly();
	ct07 = new HColorTransform().fillOnly();
	ct08 = new HColorTransform().fillOnly();
	ct09 = new HColorTransform().fillOnly();
	ct10 = new HColorTransform().fillOnly();
	ct11 = new HColorTransform().fillOnly();

	ct01.percR(0.1f); ct01.percG(0.1f); ct01.percB(0.1f);
	ct02.percR(0.3f); ct02.percG(0.3f); ct02.percB(0.3f);
	ct03.percR(0.5f); ct03.percG(0.5f); ct03.percB(0.5f);
	ct04.percR(0.7f); ct04.percG(0.7f); ct04.percB(0.7f);
	ct05.percR(0.9f); ct05.percG(0.9f); ct05.percB(0.9f);

	ct07.percR(1.1f); ct07.percG(1.1f); ct07.percB(1.1f);
	ct08.percR(1.3f); ct08.percG(1.3f); ct08.percB(1.3f);
	ct09.percR(1.5f); ct09.percG(1.5f); ct09.percB(1.5f);
	ct10.percR(1.7f); ct10.percG(1.7f); ct10.percB(1.7f);
	ct11.percR(1.9f); ct11.percG(1.9f); ct11.percB(1.9f);

	for( int i =0; i<numAssets; i++ ) {
		float x = (xSpacing*(i%numCols)) + xStart;
		float y = (ySpacing*((int)(i/numCols))) + yStart;

		rects[i] = new HRect(10, 40);
		rects[i].noStroke().loc( x, y );
		colors.applyColor(rects[i]);

		H.add(rects[i]);
	}

	for( int i=0;   i<60;  i++ ) ct01.applyColor(rects[i]); // row 01
	for( int i=60;  i<120; i++ ) ct02.applyColor(rects[i]); // row 02
	for( int i=120; i<180; i++ ) ct03.applyColor(rects[i]); // row 03
	for( int i=180; i<240; i++ ) ct04.applyColor(rects[i]); // row 04
	for( int i=240; i<300; i++ ) ct05.applyColor(rects[i]); // row 05

	for( int i=360; i<420; i++ ) ct07.applyColor(rects[i]); // row 07
	for( int i=420; i<480; i++ ) ct08.applyColor(rects[i]); // row 08
	for( int i=480; i<540; i++ ) ct09.applyColor(rects[i]); // row 09
	for( int i=540; i<600; i++ ) ct10.applyColor(rects[i]); // row 10
	for( int i=600; i<660; i++ ) ct11.applyColor(rects[i]); // row 11

	H.drawStage();

	// draw lines around original / non transformed colors from image // row 06
	stroke(#000000, 200);
	strokeWeight(3);
	line(0, 295, width, 295);
	line(0, 345, width, 345);

	noLoop();
}

void draw() {

}
