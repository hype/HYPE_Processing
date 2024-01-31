import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h, m;
color clrBg  = #242424;

// **************************************************

HRect d1, d2;

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
	m = stageW/4;

	d1 = new HRect();
	d1.rounding(10).strokeWeight(3).stroke(#FF3300).fill(#ECECEC).anchorAt(H.CENTER).size(100).loc(w-m, h);

	d2 = d1.createCopy(); // copy all properties from d1
	d2.loc(w+m, h);       // change the location / override the loc() method copied from d1
}

void draw() {
	background(clrBg);
	visualizeHelper();

	d1.draw(this.g);
	d2.draw(this.g);
}

// **************************************************

void visualizeHelper() {
	
	// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);

	ellipse(d1.x(), d1.y(), 6, 6);
	ellipse(d2.x(), d2.y(), 6, 6);

	// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, stageH/2, stageW, stageH/2);
	line(stageW/2, 0, stageW/2, stageH);

	// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
