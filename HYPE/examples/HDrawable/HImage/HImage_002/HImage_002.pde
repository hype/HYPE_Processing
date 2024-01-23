import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #00616f;
String pathToData = "../data/";

// **************************************************

HImage d1, d2, d3;

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;

	d1 = (HImage) new HImage(pathToData + "img1.jpg").anchorAt(H.CENTER).loc(w,h);
	d2 = (HImage) new HImage(pathToData + "img2.jpg").anchorAt(H.BOTTOM | H.LEFT).alpha(225).rotation(6).loc(w-350,h-150);
	d3 = (HImage) new HImage(pathToData + "img3.jpg").scale(0.7f).rotation(6).loc(d2.x(),d2.y()+25);
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
	line(0, h, width, h);
	line(w, 0, w, height);

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
