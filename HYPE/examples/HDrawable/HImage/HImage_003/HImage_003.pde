import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #242424;
String pathToData = "../data/";

// **************************************************

PImage i1;
HImage s1, s2, s3;

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;

	i1 = loadImage(pathToData + "img1.jpg");

	s1 = (HImage) new HImage(i1).anchorAt(H.CENTER).fill(#FF3300).loc(w,h);
	s2 = (HImage) new HImage(i1).anchorAt(H.CENTER).fill(#FF9900).scale(0.5f).loc(w+(s1.width()/2),h);
	s3 = (HImage) new HImage(i1).anchorAt(H.CENTER).fill(#00CC00).scale(0.5f).loc(w-(s1.width()/2),h);
}

void draw() {
	background(clrBg);

	s1.draw(this.g);
	s2.draw(this.g);
	s3.draw(this.g);

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);
	ellipse(s1.x(), s1.y(), 6, 6);
	ellipse(s2.x(), s2.y(), 6, 6);
	ellipse(s3.x(), s3.y(), 6, 6);

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
