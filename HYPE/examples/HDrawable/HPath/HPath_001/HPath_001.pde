import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;

// **************************************************

HPath d1, d2, d3, d4, d5, d6, d7, d8, d9; // declare an HPath object

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);         // initialize HYPE library
	background(clrBg);

	w = width/2;          // move the origin (0,0) to the center of the stage / x
	h = height/2;         // move the origin (0,0) to the center of the stage / y

// ************************************************** / ROW 1

	// notice that calling HPath() with no argument will NOT CLOSE the path

	d1 = new HPath();     // create an HPath object
	d1
		.vertex(0,0)
		.vertex(200,0)
		.vertex(200,200)
		.vertex(0,200)
	;
	d1.strokeWeight(4);	  // set the stroke weight
	d1.stroke(#FF9900);   // set the stroke color
	d1.fill(#111111);     // set the fill color
	d1.anchor(100,100);   // set the anchor point
	d1.loc(w-275, h-275); // set the location (x,y) of the object

	d2 = new HPath();
	d2
		.vertex(0,0)
		.vertex(200,0)
		.vertex(0,200)
		.vertex(200,200)
	;
	d2.strokeWeight(4).stroke(#FF6600).fill(#111111).anchor(100,100).loc(w, h-275);

	d3 = new HPath();
	d3
		.vertex(0,0)
		.vertex(100,25)
		.vertex(200,0)
		.vertex(175,100)
		.vertex(200,200)
		.vertex(100,175)
		.vertex(0,200)
		.vertex(25,100)
	;
	d3.strokeWeight(4).stroke(#FF3300).fill(#111111).anchor(100,100).loc(w+275, h-275);

// ************************************************** / ROW 2

	// this row is a copy of the first row, but with the path closed / by using new HPath(POLYGON) or new HPath().mode(POLYGON)

	d4 = (HPath) d1.createCopy().mode(POLYGON).loc(w-275, h);
	d5 = (HPath) d2.createCopy().mode(POLYGON).loc(w, h);
	d6 = (HPath) d3.createCopy().mode(POLYGON).loc(w+275, h);

// ************************************************** / ROW 3

	d7 = new HPath(POLYGON);
	d7
		.vertex( 75, 100,   0, 0) // need bezier curves ? / vertex(handleX, handleY, x, y)
		.vertex(200, 0)
		.vertex(200, 200)
		.vertex(0, 200)
	;
	d7.drawsHandles(true).strokeWeight(4).stroke(#FF9900).fill(#111111).anchor(100,100).loc(w-275, h+275);

	d8 = new HPath(POLYGON);
	d8
		.vertex( 75, 150,   75, 50,   0, 0) // vertex(handle1X, handle1Y, handle2X, handle2Y, x, y)
		.vertex( 200, 0 )
		.vertex( 225, 50,   125, 150, 200, 200 )
		.vertex( 0, 200 )
	;
	d8.drawsHandles(true).strokeWeight(4).stroke(#FF6600).fill(#111111).anchor(100,100).loc(w, h+275);

	d9 = (HPath) d3.createCopy().mode(POINTS).stroke(#FFFFFF).loc(w+275, h+275);

}

void draw() {
	background(clrBg);

	d1.draw(this.g); // object.draw(where to draw) / this.g = processing stage
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
	line(0, h, width, h);
	line(w, 0, w, height);

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
