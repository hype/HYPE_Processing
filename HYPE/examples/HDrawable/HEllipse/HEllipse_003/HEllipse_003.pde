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

HEllipse s1, s2, s3;
HEllipse s4, s5, s6;
HEllipse s7, s8, s9;

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

	s1 = new HEllipse(60);
	s1.noStroke().fill(#FF3300).anchorAt(H.LEFT);
	s1.loc(w-m, h-m);

	s2 = new HEllipse(60);
	s2.noStroke().fill(#009900).anchorAt(H.CENTER_X | H.TOP);
	s2.loc(w, h-m);

	s3 = new HEllipse(60);
	s3.noStroke().fill(#FF6600).anchorAt(H.TOP | H.RIGHT);
	s3.loc(w+m, h-m);

// ************************************************** ROW 2

	s4 = new HEllipse(60);
	s4.noStroke().fill(#006600).anchorAt(H.LEFT | H.CENTER_Y);
	s4.loc(w-m, h);

	s5 = new HEllipse(60);
	s5.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	s5.loc(w, h);

	s6 = new HEllipse(60);
	s6.noStroke().fill(#00CC00).anchorAt(H.RIGHT | H.CENTER_Y);
	s6.loc(w+m, h);

// ************************************************** ROW 3

	s7 = new HEllipse(60);
	s7.noStroke().fill(#FFCC00).anchorAt(H.BOTTOM | H.LEFT);
	s7.loc(w-m, h+m);

	s8 = new HEllipse(60);
	s8.noStroke().fill(#00FF00).anchorAt(H.CENTER_X | H.BOTTOM);
	s8.loc(w, h+m);

	s9 = new HEllipse(60);
	s9.noStroke().fill(#FF9900).anchorAt(H.BOTTOM | H.RIGHT);
	s9.loc(w+m, h+m);

}

void draw() {
	background(clrBg);

	r1.run();
	s1.rotation( r1.cur() ).draw(this.g);

	r2.run();
	s2.rotation( r2.cur() ).draw(this.g);

	r3.run();
	s3.rotation( r3.cur() ).draw(this.g);

	r4.run();
	s4.rotation( r4.cur() ).draw(this.g);

	s5.draw(this.g);

	r6.run();
	s6.rotation( r6.cur() ).draw(this.g);

	r7.run();
	s7.rotation( r7.cur() ).draw(this.g);

	r8.run();
	s8.rotation( r8.cur() ).draw(this.g);

	r9.run();
	s9.rotation( r9.cur() ).draw(this.g);

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

	ellipse(s4.x(), s4.y(), 6, 6);
	ellipse(s5.x(), s5.y(), 6, 6);
	ellipse(s6.x(), s6.y(), 6, 6);

	ellipse(s7.x(), s7.y(), 6, 6);
	ellipse(s8.x(), s8.y(), 6, 6);
	ellipse(s9.x(), s9.y(), 6, 6);

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
