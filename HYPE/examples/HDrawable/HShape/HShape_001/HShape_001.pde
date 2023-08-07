import hype.*;
import hype.extended.colorist.HColorPool;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

boolean s1Toggle = true;

HShape s1, s2, s3, s4; // declare an HShape object
int    sMargin = 225;

HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

void settings() {
	size(stageW, stageH);
	// fullScreen();
}

void setup() {
	H.init(this);        // initialize HYPE library
	background(clrBg);

	w = width/2;         // move the origin (0,0) to the center of the stage / x
	h = height/2;        // move the origin (0,0) to the center of the stage / y

	s1 = new HShape(pathToData + "bot1.svg");
	s1.enableStyle(true);
	s1.anchorAt(H.CENTER).loc(w-sMargin, h-sMargin);

	s2 = new HShape(pathToData + "bot1.svg");
	s2.enableStyle(false);
	s2.strokeWeight(3).stroke(#111111).fill(#111111).anchorAt(H.CENTER).loc(w+sMargin, h-sMargin);
	s2.randomColors(colors.strokeOnly());

	s3 = new HShape(pathToData + "bot1.svg");
	s3.enableStyle(false);
	s3.strokeWeight(3).stroke(#111111).fill(#111111).anchorAt(H.CENTER).loc(w-sMargin, h+sMargin);
	s3.randomColors(colors.fillOnly());

	s4 = new HShape(pathToData + "bot1.svg");
	s4.enableStyle(false);
	s4.strokeWeight(3).stroke(#111111).fill(#111111).anchorAt(H.CENTER).loc(w+sMargin, h+sMargin);
	s4.randomColors(colors.fillAndStroke());
}

void draw() {
	background(clrBg);

	if(frameCount % 60 == 0) s1Toggle = !s1Toggle;
	if (s1Toggle) s1.enableStyle(true);
	else          s1.enableStyle(false).strokeWeight(3).stroke(#FF3300).fill(#111111);

	s1.draw(this.g); // object.draw(where to draw) / this.g = processing stage
	s2.draw(this.g);
	s3.draw(this.g);
	s4.draw(this.g);

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
