import hype.*;
import hype.extended.colorist.HColorPool;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

boolean d1Toggle = true;

HShape d1, d2, d3, d4; // declare an HShape object
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

	d1 = new HShape(pathToData + "bot1.svg");
	d1.enableStyle(true);
	d1.anchorAt(H.CENTER).loc(w-sMargin, h-sMargin);

	d2 = new HShape(pathToData + "bot1.svg");
	d2.enableStyle(false);
	d2.strokeWeight(3).stroke(#111111).fill(#111111).anchorAt(H.CENTER).loc(w+sMargin, h-sMargin);
	d2.randomColors(colors.strokeOnly());

	d3 = new HShape(pathToData + "bot1.svg");
	d3.enableStyle(false);
	d3.strokeWeight(3).stroke(#111111).fill(#111111).anchorAt(H.CENTER).loc(w-sMargin, h+sMargin);
	d3.randomColors(colors.fillOnly());

	d4 = new HShape(pathToData + "bot1.svg");
	d4.enableStyle(false);
	d4.strokeWeight(3).stroke(#111111).fill(#111111).anchorAt(H.CENTER).loc(w+sMargin, h+sMargin);
	d4.randomColors(colors.fillAndStroke());
}

void draw() {
	background(clrBg);

	if(frameCount % 60 == 0) d1Toggle = !d1Toggle;
	if (d1Toggle) d1.enableStyle(true);
	else          d1.enableStyle(false).strokeWeight(3).stroke(#FF3300).fill(#111111);

	d1.draw(this.g); // object.draw(where to draw) / this.g = processing stage
	d2.draw(this.g);
	d3.draw(this.g);
	d4.draw(this.g);

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
