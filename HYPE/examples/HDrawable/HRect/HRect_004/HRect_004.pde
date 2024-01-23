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
	m = 200;

// ************************************************** ROW 1

	d1 = new HRect(100);
	d1.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d1.loc(w-m, h-m);

	d2 = new HRect(100);
	d2.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d2.loc(w, h-m);

	d3 = new HRect(100);
	d3.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d3.rotation(45).loc(w+m, h-m);

// ************************************************** ROW 2

	d4 = new HRect();
	d4.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d4.size(50,100).loc(w-m, h);

	d5 = new HRect(100);
	d5.rounding(5).strokeWeight(3).stroke(#666666).fill(#ECECEC).anchorAt(H.CENTER);
	d5.size(150,100).loc(w, h);

	d6 = new HRect(100);
	d6.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d6.visibility(false).loc(w+m, h);

// ************************************************** ROW 3

	d7 = new HRect(100);
	d7.rounding(20).strokeWeight(6).stroke(#000000).fill(#ECECEC).alpha(100).anchorAt(H.CENTER);
	d7.loc(w-m, h+m);

	d8 = new HRect(100);
	d8.roundingBL(20).strokeWeight(6).stroke(#000000, 150).fill(#ECECEC, 50).anchorAt(H.CENTER);
	d8.loc(w, h+m);

	d9 = new HRect(100);
	d9.rounding(5,10,20,30).strokeWeight(6).stroke(#000000, 100).fill(#ECECEC).anchorAt(H.CENTER);
	d9.loc(w+m, h+m);

}

void draw() {
	background(clrBg);
	visualizeHelper();

	d1.draw(this.g);
	d2.draw(this.g);
	d3.draw(this.g);

	d4.draw(this.g);
	d5.draw(this.g);
	d6.draw(this.g);

	d7.draw(this.g);
	d8.draw(this.g);
	d9.draw(this.g);
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
