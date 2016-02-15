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

	ct01.offsetR(-125); ct01.offsetG(-125); ct01.offsetB(-125);
	ct02.offsetR(-100); ct02.offsetG(-100); ct02.offsetB(-100);
	ct03.offsetR( -75); ct03.offsetG( -75); ct03.offsetB( -75);
	ct04.offsetR( -50); ct04.offsetG( -50); ct04.offsetB( -50);
	ct05.offsetR( -25); ct05.offsetG( -25); ct05.offsetB( -25);

	ct07.offsetR( 25);  ct07.offsetG( 25);  ct07.offsetB( 25);
	ct08.offsetR( 25);  ct08.offsetG( 25);  ct08.offsetB( 50);
	ct09.offsetR( 75);  ct09.offsetG( 75);  ct09.offsetB( 75);
	ct10.offsetR(100);  ct10.offsetG(100);  ct10.offsetB(100);
	ct11.offsetR(125);  ct11.offsetG(125);  ct11.offsetB(125);

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
