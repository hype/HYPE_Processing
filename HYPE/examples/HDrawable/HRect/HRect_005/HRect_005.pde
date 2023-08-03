import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h, m;
color clrBg  = #242424;

// **************************************************

HRect s1, s2;

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;
	m = 225;

	s1 = new HRect();
	s1.rounding(10).strokeWeight(3).stroke(#FF3300).fill(#ECECEC).anchorAt(H.CENTER).size(100).loc(w-m, h);

	s2 = s1.createCopy(); // copy all properties from s1
	s2.loc(w+m, h);       // change the location / override the loc() method copied from s1
}

void draw() {
	background(clrBg);
	visualizeHelper();

	s1.draw(this.g);
	s2.draw(this.g);
}

// **************************************************

void visualizeHelper() {
	
// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);

	ellipse(s1.x(), s1.y(), 6, 6);
	ellipse(s2.x(), s2.y(), 6, 6);

// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, height/2, width, height/2);
	line(width/2, 0, width/2, height);

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
