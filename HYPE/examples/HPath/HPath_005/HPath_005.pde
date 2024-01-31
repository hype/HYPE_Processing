import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;

// **************************************************

HPath d1, d2, d3, d4, d5, d6, d7, d8, d9;

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

// ************************************************** / ROW 1

	d1 = (HPath) new HPath().polygon( 3 ).size(200).strokeWeight(4).stroke(#FF9900).fill(#111111).anchor(100,100).rotation(-90).loc(w-275, h-275);
	d2 = (HPath) new HPath().polygon( 4 ).size(200).strokeWeight(4).stroke(#FF6600).fill(#111111).anchor(100,100).rotation(-90).loc(w, h-275);
	d3 = (HPath) new HPath().polygon( 5 ).size(200).strokeWeight(4).stroke(#FF3300).fill(#111111).anchor(100,100).rotation(-90).loc(w+275, h-275);

// ************************************************** / ROW 2

	d4 = (HPath) new HPath().polygon( 6 ).size(200).strokeWeight(4).stroke(#FF9900).fill(#111111).anchor(100,100).rotation(-90).loc(w-275, h);
	d5 = (HPath) new HPath().polygon( 7 ).size(200).strokeWeight(4).stroke(#FF6600).fill(#111111).anchor(100,100).rotation(-90).loc(w, h);
	d6 = (HPath) new HPath().polygon( 8 ).size(200).strokeWeight(4).stroke(#FF3300).fill(#111111).anchor(100,100).rotation(-90).loc(w+275, h);

// ************************************************** / ROW 3

	d7 = (HPath) new HPath().polygon( 9 ).size(200).strokeWeight(4).stroke(#FF9900).fill(#111111).anchor(100,100).rotation(-90).loc(w-275, h+275);
	d8 = (HPath) new HPath().polygon( 10 ).size(200).strokeWeight(4).stroke(#FF6600).fill(#111111).anchor(100,100).rotation(-90).loc(w, h+275);
	d9 = (HPath) new HPath().polygon( 11 ).size(200).strokeWeight(4).stroke(#FF3300).fill(#111111).anchor(100,100).rotation(-90).loc(w+275, h+275);
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

	ellipse(d4.x(), d4.y(), 6, 6);
	ellipse(d5.x(), d5.y(), 6, 6);
	ellipse(d6.x(), d6.y(), 6, 6);

	ellipse(d7.x(), d8.y(), 6, 6);
	ellipse(d8.x(), d8.y(), 6, 6);
	ellipse(d9.x(), d9.y(), 6, 6);

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
