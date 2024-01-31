import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h, m;
color clrBg  = #242424;

// **************************************************

HRect    d1, d2, d3, d4;    // ROW 1
HRect    d5, d6, d7, d8;    // ROW 2
HRect    d9, d10, d11, d12; // ROW 3
HRect    d13, d16;          // ROW 4
HEllipse d14, d15;          // ROW 4

void settings() {
	size(stageW, stageH, P3D);
}

void setup() {
	H.init(this);
	background(clrBg);

	w = stageW/2; // move the origin (0,0) to the center of the stage / x
	h = stageH/2; // move the origin (0,0) to the center of the stage / y
	m = stageW/5; // create a margin to space the items out evenly

// ************************************************** ROW 1

	d1 = new HRect();
	d1.noStroke().fill(#ECECEC).loc(m*1-50,m*1-50);

	d2 = new HRect();
	d2.rounding(10).noStroke().fill(#ECECEC).loc(m*2-50,m*1-50);

	d3 = new HRect();
	d3.rounding(10).noStroke().fill(#ECECEC).anchorAt(H.CENTER).rotation(45).loc(m*3,m*1);

	d4 = new HRect();
	d4.rounding(10).noStroke().fill(236).loc(m*4-50,m*1-50); // so many different ways to set fill() color / 236, grayscale applied to RGB

// ************************************************** ROW 2

	d5 = new HRect();
	d5.rounding(10).noStroke().fill(#ECECEC).anchorAt(H.CENTER).size(50,100).loc(m*1,m*2);

	d6 = new HRect();
	d6.rounding(10).strokeWeight(3).stroke(#666666).fill(#ECECEC).anchorAt(H.CENTER).size(150,100).loc(m*2,m*2);

	d7 = new HRect();
	d7.rounding(10).noStroke().fill(#ECECEC).anchorAt(H.CENTER).size(100,100).loc(m*3,m*2).visibility(false); // rect is hidden from stage

	d8 = new HRect();
	d8.rounding(10).noStroke().fill(255, 51, 0).anchorAt(H.CENTER).loc(m*4,m*2); // so many different ways to set color / 255 red, 51 green, 0 blue

// ************************************************** ROW 3

	d9 = new HRect(100);
	d9.rounding(10).strokeWeight(6).stroke(#000000).fill(#ECECEC).anchorAt(H.CENTER).loc(m*1,m*3).alpha(100); // alpha 100 is applied globally to both fill and stroke

	d10 = new HRect(100);
	d10.rounding(10).strokeWeight(6).stroke(#000000, 150).fill(#ECECEC, 50).anchorAt(H.CENTER).loc(m*2,m*3); // stroke with alpha 200 / fill with alpha 50

	d11 = new HRect(100);
	d11.rounding(10).strokeWeight(6).stroke(#000000, 100).fill(#ECECEC).anchorAt(H.CENTER).loc(m*3,m*3); // no fill color alpha

	d12 = new HRect(100);
	d12.rounding(10).strokeWeight(6).noStroke().fill(#FF6600).anchorAt(H.CENTER).loc(m*4,m*3); // so many different ways to set color / #FF6600 hex value

// ************************************************** ROW 4

	d13 = new HRect(100);
	d13.rounding(10).strokeWeight(6).stroke(#ECECEC).noFill().anchorAt(H.CENTER).loc(m*1,m*4);

	d14 = new HEllipse(50);
	d14.noStroke().fill(#ECECEC).anchorAt(H.CENTER).loc(m*2,m*4);

	d15 = new HEllipse(50);
	d15.stroke(#ECECEC).noFill().anchorAt(H.CENTER).loc(m*3,m*4);

	d16 = new HRect(100);
	d16.rounding(10).strokeWeight(6).noStroke().fill(0xFFFF9900).anchorAt(H.CENTER).loc(m*4,m*4); // so many different ways to set color / 0xFFFF9900 hex value 0xAARRGGBB
}

void draw() {
	background(clrBg);

	d1.draw(this.g);
	d2.draw(this.g);
	d3.draw(this.g);
	d4.draw(this.g);

	d5.draw(this.g);
	d6.draw(this.g);
	d7.draw(this.g);
	d8.draw(this.g);

	d9.draw(this.g);
	d10.draw(this.g);
	d11.draw(this.g);
	d12.draw(this.g);

	d13.draw(this.g);
	d14.draw(this.g);
	d15.draw(this.g);
	d16.draw(this.g);

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
