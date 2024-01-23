import hype.*;
import hype.extended.behavior.HOscillator;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

PImage        i1;

int           numAssets = 25;
HCylinder[]   d  = new HCylinder[numAssets];
HOscillator[] oX = new HOscillator[numAssets];
HOscillator[] oY = new HOscillator[numAssets];
HOscillator[] oZ = new HOscillator[numAssets];

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this); // initialize HYPE library
	background(clrBg);

	w = width/2;  // move the origin (0,0) to the center of the stage / x
	h = height/2; // move the origin (0,0) to the center of the stage / y

	i1 = loadImage(pathToData + "tex5.png"); // image used for HCylinder texture

	for (int i = 0; i < numAssets; ++i) {
		d[i] = new HCylinder(); // create an HCylinder object
		d[i].size(250+(i*5));   // set the size of the object
		d[i].stroke(#CCCCCC);   // set the stroke color
		d[i].fill(#FF3300);     // set the fill color
		d[i].loc(w, h);         // set the location (x,y) of the object
		d[i].texture(i1);       // set the texture of the object

		oX[i] = new HOscillator().range(-360, 360).speed(0.1).freq(1).currentStep(i*1.25);
		oY[i] = new HOscillator().range(-360, 360).speed(0.2).freq(1).currentStep(i*1.25);
		oZ[i] = new HOscillator().range(-360, 360).speed(0.3).freq(1).currentStep(i*1.25);
	}
}

void draw() {
	background(clrBg);

	lights();

	for (int i = 0; i < numAssets; ++i) {
		oX[i].run();
		oY[i].run();
		oZ[i].run();

		d[i].rotationX(oX[i].cur());
		d[i].rotationY(oY[i].cur());
		d[i].rotationZ(oZ[i].cur());
		d[i].draw(this.g);
	}

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, h, width, h);
	line(w, 0, w, height);

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
