import hype.*;

int     stageW = 900;
int     stageH = 900;
color   clrBg  = #242424;
String  pathToData = "../data/";

// **************************************************

HCanvas canvas;

// **************************************************

HRect   d1; 

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this); // initialize HYPE library
	background(clrBg);

	d1 = (HRect) new HRect().rounding(5).size(50).noStroke().fill(#FF3300).loc(0, 0).anchorAt(H.CENTER).rotate(45);

    canvas = new HCanvas(stageW, stageH, P3D); // create an HCanvas object / an advanced PGraphics container
	canvas.autoClear(false);                   // tell the HCanvas not to clear the background each frame
	canvas.fade(5);                            // set the fade value for the background clear / uses loadPixels() and updatePixels() for better fading
}

void draw() {
	background(clrBg);

	d1.size( 20+((int)random(5)*20) ).loc( (int)random(stageW), (int)random(stageH)); // randomly change the size and location of the rectangle

	canvas.graphics().beginDraw();  // lets start to paint to the HCanvas
	d1.draw(canvas.graphics());     // lets draw the "d1" HRect object to the HCanvas
	canvas.graphics().endDraw();    // lets stop painting to the HCanvas

	canvas.run();                   // lets paint the buffer / this happens offscreen / use canvas.graphics() to see what was painted

	image(canvas.graphics(), 0, 0); // preview what was painted to the HCanvas

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

	// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
