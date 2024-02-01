import hype.*;

int     stageW = 900;
int     stageH = 900;
int     w, h;
color   clrBg  = #242424;
String  pathToData = "../data/";

// **************************************************

HCanvas canvas1, canvas2, canvas3, canvas4;

// **************************************************

HRect   d1, d2, d3, d4; 

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this); // initialize HYPE library
	background(clrBg);

	w = stageW/2;       // move the origin (0,0) to the center of the stage / x
	h = stageH/2;       // move the origin (0,0) to the center of the stage / y

	d1 = (HRect) new HRect().rounding(5).size(50).strokeWeight(1).stroke(#ECECEC).fill(#FF3300).loc(0, 0).anchorAt(H.CENTER).rotate(45);

    canvas1 = new HCanvas(w, h, P3D).autoClear(true); // create an HCanvas object / an advanced PGraphics container
	canvas2 = canvas1.createCopy().background(#00FF00);
	canvas3 = canvas1.createCopy().autoClear(false);
	canvas4 = canvas1.createCopy().autoClear(false).fade(3); // 0 = no fade / 1 = slowest / 10+ = faster / float not supported

	canvas1.add(d1);
	canvas2.add(d2 = d1.createCopy());
	canvas3.add(d3 = d1.createCopy());
	canvas4.add(d4 = d1.createCopy());
}

void draw() {
	background(clrBg);

	d1.size( 20+((int)random(5)*20) ).loc( (int)random(w), (int)random(h)); // randomly change the size and location of the rectangle
	d2.size( 20+((int)random(5)*20) ).loc( (int)random(w), (int)random(h));
	d3.size( 20+((int)random(5)*20) ).loc( (int)random(w), (int)random(h));
	d4.size( 20+((int)random(5)*20) ).loc( (int)random(w), (int)random(h));

	canvas1.run();                   // lets paint the buffer / this happens offscreen / use canvas.graphics() to see what was painted
	image(canvas1.graphics(), 0, 0); // preview what was painted to the HCanvas

	canvas2.run();
	image(canvas2.graphics(), w, 0);

	canvas3.run();
	image(canvas3.graphics(), 0, h);

	canvas4.run();
	image(canvas4.graphics(), w, h);

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

	// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
