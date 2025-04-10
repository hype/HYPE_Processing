import hype.*;
import hype.extended.behavior.HRotate;

int     stageW = 900;
int     stageH = 900;
int     w, h;
color   clrBg  = #242424;
String  pathToData = "../data/";

// **************************************************

HCanvas canvas1, canvas2, canvas3, canvas4;

// **************************************************

HRotate r1;

HRect   d1, d2, d3, d4; 
int     dW = 100;

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this); // initialize HYPE library
	background(clrBg);

	w = stageW/2; // move the origin (0,0) to the center of the stage / x
	h = stageH/2; // move the origin (0,0) to the center of the stage / y

	r1 = new HRotate().speed(1.0);

	d1 = (HRect) new HRect().rounding(20).size(dW).strokeWeight(1).stroke(#FF3300).fill(#0095a8).loc(w/2, h/2).anchor(dW/2, -50);

    canvas1 = new HCanvas(w, h, P3D).autoClear(false).fade(0);
	canvas2 = canvas1.createCopy().autoClear(false).fade(1);
	canvas3 = canvas1.createCopy().autoClear(false).fade(1);
	canvas4 = canvas1.createCopy().autoClear(false).fade(1);

	canvas1.add(d1);
	canvas2.add(d2 = (HRect) d1.createCopy() );
	canvas3.add(d3 = (HRect) d1.createCopy().noFill() );
	canvas4.add(d4 = (HRect) d1.createCopy().noStroke() );
}

void draw() {
	background(clrBg);

	r1.run();
	d1.rotation( r1.cur() );
	d2.rotation( r1.cur() );
	d3.rotation( r1.cur() );
	d4.rotation( r1.cur() );

	canvas1.run();
	canvas2.run();
	canvas3.run();
	canvas4.run();

	image(canvas1.graphics(), 0, 0);
	image(canvas2.graphics(), w, 0);
	image(canvas3.graphics(), 0, h);
	image(canvas4.graphics(), w, h);

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

	// visualize the x,y anchor point of the object

	// strokeWeight(2);
	// stroke(#0095a8);
	// fill(#333333);

	// ellipse( d1.x(), d1.y(), 6, 6);

	// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(stageW*0.25, 0, stageW*0.25, stageH);
	line(stageW*0.75, 0, stageW*0.75, stageH);
	line(0, stageH*0.25, stageW, stageH*0.25);
	line(0, stageH*0.75, stageW, stageH*0.75);

	stroke(#999999);

	line(stageW*0.5, 0, stageW*0.5, stageH);
	line(0, stageH*0.5, stageW, stageH*0.5);

	// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}

