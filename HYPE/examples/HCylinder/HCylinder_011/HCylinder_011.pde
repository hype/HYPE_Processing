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

// COLOR

HImage        c1;
HRect         clrMarker;
HOscillator[] oC = new HOscillator[numAssets];

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

	c1 = (HImage) new HImage(pathToData + "color.png").loc(0, 0); // image used for coloring
	clrMarker = (HRect) new HRect(2, 40).strokeWeight(0).noStroke().fill(#CCCCCC).anchorAt(H.CENTER).loc(0, 10);

	i1 = loadImage(pathToData + "tex5.png"); // image used for HCylinder texture

	for (int i = 0; i < numAssets; ++i) {
		d[i] = new HCylinder(); // create an HCylinder object
		d[i].size(250+(i*5));   // set the size of the object
		d[i].noStroke();        // set the stroke color
		d[i].fill(#FF3300);     // set the fill color
		d[i].loc(w, h);         // set the location (x,y) of the object

		d[i].texture(i1);       // set the texture of the object

		oX[i] = new HOscillator().range(-360, 360).speed(0.1).freq(1).currentStep(i*1.25);
		oY[i] = new HOscillator().range(-360, 360).speed(0.2).freq(1).currentStep(i*1.25);
		oZ[i] = new HOscillator().range(-360, 360).speed(0.3).freq(1).currentStep(i*1.25);

		oC[i] = new HOscillator().range(0, c1.width()-1).speed(0.5).freq(1).currentStep(i*10).waveform(H.SAW);
	}
}

void draw() {
	background(clrBg);
	noLights();

	c1.draw(this.g); // draw the image used for coloring

	for (int i = 0; i < numAssets; ++i) {
		oC[i].run();                              // run the oscillator used for the coloring
		clrMarker.x(oC[i].cur()).draw(this.g);    // draw the markers (25) used for the coloring
		color _c = c1.getColor( oC[i].cur(), 1 ); // get the color from the image used for coloring

		oX[i].run();
		oY[i].run();
		oZ[i].run();

		d[i].rotationX(oX[i].cur());
		d[i].rotationY(oY[i].cur());
		d[i].rotationZ(oZ[i].cur());
		d[i].fill(_c).draw(this.g);
	}

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

	// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, h, stageW, h);
	line(w, 0, w, stageH);

	// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
