import hype.*;
import hype.extended.behavior.HRotate;

int      stageW = 900;
int      stageH = 900;
int      w, h, m;
color    clrBg  = #242424;

// **************************************************

HRotate r1, r2, r3;
HRotate r4, r5, r6;
HRotate r7, r8, r9;

HEllipse d1, d2, d3;
HEllipse d4, d5, d6;
HEllipse d7, d8, d9;

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

	r1 = new HRotate().speed(1.0);
	r2 = new HRotate().speed(1.0);
	r3 = new HRotate().speed(1.0);
	r4 = new HRotate().speed(1.0);
	r5 = new HRotate().speed(1.0);
	r6 = new HRotate().speed(1.0);
	r7 = new HRotate().speed(1.0);
	r8 = new HRotate().speed(1.0);
	r9 = new HRotate().speed(1.0);

	//   anchorAt() will take any combination of the following constants:
	// - H.LEFT
	// - H.CENTER_X -- equals to (H.LEFT | H.RIGHT)
	// - H.RIGHT
	// - H.TOP
	// - H.CENTER_Y -- equals to (H.TOP | H.BOTTOM)
	// - H.BOTTOM
	// - H.CENTER -- equals to (H.CENTER_X | H.CENTER_Y)

// ************************************************** ROW 1

	d1 = new HEllipse(60);
	d1.noStroke().fill(#FF3300).anchorAt(H.LEFT);
	d1.loc(w-m, h-m);

	d2 = new HEllipse(60);
	d2.noStroke().fill(#009900).anchorAt(H.CENTER_X | H.TOP);
	d2.loc(w, h-m);

	d3 = new HEllipse(60);
	d3.noStroke().fill(#FF6600).anchorAt(H.TOP | H.RIGHT);
	d3.loc(w+m, h-m);

// ************************************************** ROW 2

	d4 = new HEllipse(60);
	d4.noStroke().fill(#006600).anchorAt(H.LEFT | H.CENTER_Y);
	d4.loc(w-m, h);

	d5 = new HEllipse(60);
	d5.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d5.loc(w, h);

	d6 = new HEllipse(60);
	d6.noStroke().fill(#00CC00).anchorAt(H.RIGHT | H.CENTER_Y);
	d6.loc(w+m, h);

// ************************************************** ROW 3

	d7 = new HEllipse(60);
	d7.noStroke().fill(#FFCC00).anchorAt(H.BOTTOM | H.LEFT);
	d7.loc(w-m, h+m);

	d8 = new HEllipse(60);
	d8.noStroke().fill(#00FF00).anchorAt(H.CENTER_X | H.BOTTOM);
	d8.loc(w, h+m);

	d9 = new HEllipse(60);
	d9.noStroke().fill(#FF9900).anchorAt(H.BOTTOM | H.RIGHT);
	d9.loc(w+m, h+m);

}

void draw() {
	background(clrBg);

	r1.run();
	d1.rotation( r1.cur() ).draw(this.g);

	r2.run();
	d2.rotation( r2.cur() ).draw(this.g);

	r3.run();
	d3.rotation( r3.cur() ).draw(this.g);

	r4.run();
	d4.rotation( r4.cur() ).draw(this.g);

	d5.draw(this.g);

	r6.run();
	d6.rotation( r6.cur() ).draw(this.g);

	r7.run();
	d7.rotation( r7.cur() ).draw(this.g);

	r8.run();
	d8.rotation( r8.cur() ).draw(this.g);

	r9.run();
	d9.rotation( r9.cur() ).draw(this.g);

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
