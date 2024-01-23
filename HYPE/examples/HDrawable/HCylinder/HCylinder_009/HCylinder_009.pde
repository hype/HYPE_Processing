import hype.*;
import hype.extended.behavior.HRotate;

int    stageW = 900;
int    stageH = 900;
int    w, h, m;
color  clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HCylinder d0_1, d0_2, d0_3, d0_4, d0_5, d0_6;
HCylinder d1_1, d1_2, d1_3, d1_4, d1_5, d1_6;

int       dSize = 125;

HRotate   r1;

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this); // initialize HYPE library
	background(clrBg);

	w = width/2;  // move the origin (0,0) to the center of the stage / x
	h = height/2; // move the origin (0,0) to the center of the stage / y
	m = stageW/4; // margin = 1/4 of the stage width

	r1 = new HRotate().speed(1.0);

	// create 6 orange inner cylinders / no textures
	d0_1 = (HCylinder) new HCylinder().depth(dSize).width(dSize).height(dSize*1.75).noStroke().fill(#FF3300).loc(w-m, h-m);
	d0_2 = (HCylinder) d0_1.createCopy().loc(w,   h-m);
	d0_3 = (HCylinder) d0_1.createCopy().loc(w+m, h-m);
	d0_4 = (HCylinder) d0_1.createCopy().loc(w-m, h+m);
	d0_5 = (HCylinder) d0_1.createCopy().loc(w,   h+m);
	d0_6 = (HCylinder) d0_1.createCopy().loc(w+m, h+m);


	d1_1 = (HCylinder) d0_1.createCopy().texture(pathToData + "tex1.png").depth(d0_1.depth()*1.2).width(d0_1.width()*1.2).height(d0_1.height()*1.2).fill(#FFFFFF);
	d1_2 = (HCylinder) d0_2.createCopy().texture(pathToData + "tex2.png").depth(d0_2.depth()*1.2).width(d0_2.width()*1.2).height(d0_2.height()*1.2).fill(#FFFFFF);
	d1_3 = (HCylinder) d0_3.createCopy().texture(pathToData + "tex3.png").depth(d0_3.depth()*1.2).width(d0_3.width()*1.2).height(d0_3.height()*1.2).fill(#FFFFFF);
	d1_4 = (HCylinder) d0_4.createCopy().texture(pathToData + "tex4.png").depth(d0_4.depth()*1.2).width(d0_4.width()*1.2).height(d0_4.height()*1.2).fill(#FFFFFF);
	d1_5 = (HCylinder) d0_5.createCopy().texture(pathToData + "tex5.png").depth(d0_5.depth()*1.2).width(d0_5.width()*1.2).height(d0_5.height()*1.2).fill(#FFFFFF);
	d1_6 = (HCylinder) d0_6.createCopy().texture(pathToData + "tex6.png").depth(d0_6.depth()*1.2).width(d0_6.width()*1.2).height(d0_6.height()*1.2).fill(#FFFFFF);
}

void draw() {
	background(clrBg);

	// Be wary when using these hints, they are there to help with z depth clipping issues.
	// They can have performance issues when there's a lot of overlapping objects on screen.
	// the clipping issues occur because we are painting with transparent PNGs

	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	// ortho();
	lights();

	d0_1.draw(this.g);
	d0_2.draw(this.g);
	d0_3.draw(this.g);
	d0_4.draw(this.g);
	d0_5.draw(this.g);
	d0_6.draw(this.g);

	r1.run();

	d1_1.rotationY( r1.cur() ).draw(this.g);
	d1_2.rotationY( r1.cur() ).draw(this.g);
	d1_3.rotationY( r1.cur() ).draw(this.g);
	d1_4.rotationY( r1.cur() ).draw(this.g);
	d1_5.rotationY( r1.cur() ).draw(this.g);
	d1_6.rotationY( r1.cur() ).draw(this.g);

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
