import hype.*;
import hype.extended.behavior.HRotate;

int    stageW = 900;
int    stageH = 900;
int    w, h, m;
color  clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HCylinder d1_1, d1_2, d1_3, d1_4, d1_5, d1_6;
int       dSize = 150;

HRotate   r1, r2, r3, r4, r5, r6;

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
	m = stageW/4; // margin = 1/4 of the stage stageW

	r1 = new HRotate().speed(1.0);
	r2 = new HRotate().speed(1.0);
	r3 = new HRotate().speed(1.0);
	r4 = new HRotate().speed(1.0);
	r5 = new HRotate().speed(1.0);
	r6 = new HRotate().speed(1.0);

	d1_1 = (HCylinder) new HCylinder().depth(dSize).width(dSize).height(dSize*1.75).noStroke().fill(#FFFFFF).loc(w-m, h-m);
	d1_1.texture(pathToData + "tex1.png");

	d1_2 = (HCylinder) d1_1.createCopy().texture(pathToData + "tex2.png").loc(w,   h-m);
	d1_3 = (HCylinder) d1_1.createCopy().texture(pathToData + "tex3.png").loc(w+m, h-m);
	d1_4 = (HCylinder) d1_1.createCopy().texture(pathToData + "tex4.png").loc(w-m, h+m);
	d1_5 = (HCylinder) d1_1.createCopy().texture(pathToData + "tex5.png").loc(w,   h+m);
	d1_6 = (HCylinder) d1_1.createCopy().texture(pathToData + "tex6.png").loc(w+m, h+m);
}

void draw() {
	background(clrBg);

	// Be wary when using these hints, they are there to help with z depth clipping issues.
	// They can have performance issues when there's a lot of overlapping objects on screen.
	// the clipping issues occur because we are painting with transparent PNGs

	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	ortho();
	lights();

	r1.run(); d1_1.rotationY( r1.cur() ).draw(this.g);
	r2.run(); d1_2.rotationY( r2.cur() ).draw(this.g);
	r3.run(); d1_3.rotationY( r3.cur() ).draw(this.g);
	r4.run(); d1_4.rotationY( r4.cur() ).draw(this.g);
	r5.run(); d1_5.rotationY( r5.cur() ).draw(this.g);
	r6.run(); d1_6.rotationY( r6.cur() ).draw(this.g);

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
