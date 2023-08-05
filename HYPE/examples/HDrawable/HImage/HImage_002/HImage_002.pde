import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #00616f;
String pathToData = "../data/";

// **************************************************

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

	s1 = (HImage) new HImage(pathToData + "img1.jpg").anchorAt(H.CENTER).loc(w,h);
	s2 = (HImage) new HImage(pathToData + "img2.jpg").anchorAt(H.BOTTOM | H.LEFT).alpha(225).rotation(6).loc(w-350,h-150);
	s3 = (HImage) new HImage(pathToData + "img3.jpg").scale(0.7f).rotation(6).loc(s2.x(),s2.y()+25);
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
