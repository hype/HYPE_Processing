import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #242424;
String pathToData = "../data/";               // relative path to the data folder

// **************************************************

HImage d1;                                    // declare an HImage object

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);                             // initialize HYPE library
	background(clrBg);

	w = width/2;                              // move the origin (0,0) to the center of the stage / x
	h = height/2;                             // move the origin (0,0) to the center of the stage / y

	d1 = new HImage(pathToData + "img1.jpg"); // create an HImage object and load an image
	d1.anchorAt(H.CENTER);                    // set the anchor point of the object
	d1.loc(w, h);                             // set the location (x,y) of the object
}

void draw() {
	background(clrBg);

	d1.draw(this.g);                          // object.draw(where to draw) / this.g = processing stage

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333); 
	ellipse(d1.x(), d1.y(), 6, 6);

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
