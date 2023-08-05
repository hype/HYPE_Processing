import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;

// **************************************************

HPath s1, s2, s3, s4, s5, s6, s7, s8, s9; // declare an HPath object

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this); // initialize HYPE library
	background(clrBg);

	w = width/2; // move the origin (0,0) to the center of the stage / x
	h = height/2; // move the origin (0,0) to the center of the stage / y

// ************************************************** / ROW 1

	// notice that calling HPath() with no argument will NOT CLOSE the path

	s1 = new HPath(); // create an HPath object
	s1
		.vertex(0,0)
		.vertex(200,0)
		.vertex(200,200)
		.vertex(0,200)
	;
	s1.strokeWeight(4);	// set the stroke weight
	s1.stroke(#FF9900); // set the stroke color
	s1.fill(#111111); // set the fill color
	s1.anchor(100,100); // set the anchor point
	s1.loc(w-275, h-275); // set the location (x,y) of the object

	s2 = new HPath();
	s2
		.vertex(0,0)
		.vertex(200,0)
		.vertex(0,200)
		.vertex(200,200)
	;
	s2.strokeWeight(4).stroke(#FF6600).fill(#111111).anchor(100,100).loc(w, h-275);

	s3 = new HPath();
	s3
		.vertex(0,0)
		.vertex(100,25)
		.vertex(200,0)
		.vertex(175,100)
		.vertex(200,200)
		.vertex(100,175)
		.vertex(0,200)
		.vertex(25,100)
	;
	s3.strokeWeight(4).stroke(#FF3300).fill(#111111).anchor(100,100).loc(w+275, h-275);

// ************************************************** / ROW 2

	// this row is a copy of the first row, but with the path closed / by using new HPath(POLYGON) or new HPath().mode(POLYGON)

	s4 = (HPath) s1.createCopy().mode(POLYGON).loc(w-275, h);
	s5 = (HPath) s2.createCopy().mode(POLYGON).loc(w, h);
	s6 = (HPath) s3.createCopy().mode(POLYGON).loc(w+275, h);

// ************************************************** / ROW 3

	int x1 = 0;
	int x2 = 200;
	int y1 = 0;
	int y2 = 200;

	s7 = new HPath(POLYGON);
	s7
		.vertex( x1+50, y1+50,   x1, y1) // need bezier curves ? / vertex(handleX, handleY, x, y)
		.vertex(x2, y1)
		.vertex(x2, y2)
		.vertex(x1, y2)
	;
	s7.drawsHandles(true).strokeWeight(4).stroke(#FF3300).fill(#FFFFFF).anchor(100,100).loc(w-275, h+275);

	s8 = new HPath(POLYGON);
	s8
		.vertex( x1+50, y1+50,   x1+100, y1+100,   x1, y1) // vertex(handle1X, handle1Y, handle2X, handle2Y, x, y)
		.vertex( x2-50, y1+50,   x2-100, y1+100,   x2, y1)
		.vertex( x2-50, y2-50,   x2-100, y2-100,   x2, y2)
		.vertex( x1+50, y2-50,   x1+100, y2-100,   x1, y2)
	;
	s8.drawsHandles(false).strokeWeight(4).stroke(#FF3300).fill(#FFFFFF).anchor(100,100).loc(w, h+275);

	s9 = (HPath) s3.createCopy().mode(POINTS).stroke(#FFFFFF).loc(w+275, h+275);

}

void draw() {
	background(clrBg);

	s1.draw(this.g); // object.draw(where to draw) / this.g = processing stage
	s2.draw(this.g);
	s3.draw(this.g);

	s4.draw(this.g);
	s5.draw(this.g);
	s6.draw(this.g);

	s7.draw(this.g);
	s8.draw(this.g);
	s9.draw(this.g);

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

	ellipse(s7.x(), s8.y(), 6, 6);
	ellipse(s8.x(), s8.y(), 6, 6);
	ellipse(s9.x(), s9.y(), 6, 6);

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
