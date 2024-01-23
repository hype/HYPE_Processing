import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h, m;
color clrBg  = #242424;

// **************************************************

HRect d1, d2, d3;
HRect d4, d5, d6;
HRect d7, d8, d9;

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;
	m = 225; // margin

	//   anchorAt() will take any combination of the following constants:
	// - H.LEFT
	// - H.CENTER_X -- equals to (H.LEFT | H.RIGHT)
	// - H.RIGHT
	// - H.TOP
	// - H.CENTER_Y -- equals to (H.TOP | H.BOTTOM)
	// - H.BOTTOM
	// - H.CENTER -- equals to (H.CENTER_X | H.CENTER_Y)

// ************************************************** ROW 1

	d1 = new HRect(100);
	d1.rounding(5).noStroke().fill(#FF3300).anchorAt(H.LEFT);
	d1.loc(w-m, h-m);

	d2 = new HRect(100);
	d2.rounding(5).noStroke().fill(#009900).anchorAt(H.CENTER_X | H.TOP);
	d2.loc(w, h-m);

	d3 = new HRect(100);
	d3.rounding(5).noStroke().fill(#FF6600).anchorAt(H.TOP | H.RIGHT);
	d3.loc(w+m, h-m);

// ************************************************** ROW 2

	d4 = new HRect(100);
	d4.rounding(5).noStroke().fill(#006600).anchorAt(H.LEFT | H.CENTER_Y);
	d4.loc(w-m, h);

	d5 = new HRect(100);
	d5.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d5.loc(w, h);

	d6 = new HRect(100);
	d6.rounding(5).noStroke().fill(#00CC00).anchorAt(H.RIGHT | H.CENTER_Y);
	d6.loc(w+m, h);

// ************************************************** ROW 3

	d7 = new HRect(100);
	d7.rounding(5).noStroke().fill(#FFCC00).anchorAt(H.BOTTOM | H.LEFT);
	d7.loc(w-m, h+m);

	d8 = new HRect(100);
	d8.rounding(5).noStroke().fill(#00FF00).anchorAt(H.CENTER_X | H.BOTTOM);
	d8.loc(w, h+m);

	d9 = new HRect(100);
	d9.rounding(5).noStroke().fill(#FF9900).anchorAt(H.BOTTOM | H.RIGHT);
	d9.loc(w+m, h+m);

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

	ellipse(d7.x(), d7.y(), 6, 6);
	ellipse(d8.x(), d8.y(), 6, 6);
	ellipse(d9.x(), d9.y(), 6, 6);

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
