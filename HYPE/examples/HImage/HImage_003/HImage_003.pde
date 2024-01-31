import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #242424;
String pathToData = "../data/";

// **************************************************

PImage i1;
HImage d1, d2, d3;

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = stageW/2;
	h = stageH/2;

	i1 = loadImage(pathToData + "img1.jpg");

	d1 = (HImage) new HImage(i1).anchorAt(H.CENTER).fill(#FF3300).loc(w,h);
	d2 = (HImage) new HImage(i1).anchorAt(H.CENTER).fill(#FF9900).scale(0.5f).loc(w+(d1.width()/2),h);
	d3 = (HImage) new HImage(i1).anchorAt(H.CENTER).fill(#00CC00).scale(0.5f).loc(w-(d1.width()/2),h);
}

void draw() {
	background(clrBg);

	d1.draw(this.g);
	d2.draw(this.g);
	d3.draw(this.g);

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

	// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);
	ellipse(d1.x(), d1.y(), 6, 6);
	ellipse(d2.x(), d2.y(), 6, 6);
	ellipse(d3.x(), d3.y(), 6, 6);

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
