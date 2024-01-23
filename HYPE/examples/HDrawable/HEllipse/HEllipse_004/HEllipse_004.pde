import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h, m;
color clrBg  = #242424;

// **************************************************

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
	m = 200;

// ************************************************** ROW 1

	d1 = new HEllipse(60).start(45);
	d1.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d1.loc(w-m, h-m);

	d2 = new HEllipse(60).start(45).end(90);
	d2.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d2.loc(w, h-m);

	d3 = new HEllipse(60).start(0).end(180);
	d3.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d3.rotation(180).loc(w+m, h-m);

// ************************************************** ROW 2

	d4 = new HEllipse();
	d4.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d4.size(50,100).loc(w-m, h);

	d5 = new HEllipse(60);
	d5.strokeWeight(3).stroke(#666666).fill(#ECECEC).anchorAt(H.CENTER);
	d5.size(150,100).loc(w, h);

	d6 = new HEllipse(60);
	d6.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	d6.visibility(false).loc(w+m, h);

// ************************************************** ROW 3

	d7 = new HEllipse(60);
	d7.strokeWeight(6).stroke(#000000).fill(#ECECEC).alpha(100).anchorAt(H.CENTER);
	d7.loc(w-m, h+m);

	d8 = new HEllipse(60);
	d8.strokeWeight(6).stroke(#000000, 150).fill(#ECECEC, 50).anchorAt(H.CENTER);
	d8.loc(w, h+m);

	d9 = new HEllipse(60);
	d9.strokeWeight(6).stroke(#000000, 100).fill(#ECECEC).anchorAt(H.CENTER);
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
