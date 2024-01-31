import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h, m;
color clrBg  = #242424;

// **************************************************

HRect d1, d2, d3;

void settings() {
	size(stageW, stageH, P3D);
}

void setup() {
	H.init(this);
	background(clrBg);

	w = stageW/2; // move the origin (0,0) to the center of the stage / x
	h = stageH/2; // move the origin (0,0) to the center of the stage / y
	m = stageW/5; // create a margin to space the items out evenly

	d1 = new HRect(100);     // create a new HRect object and size
	d1.rounding(10);         // set corner rounding
	d1.strokeWeight(6);      // set stroke weight
	d1.stroke(#000000, 150); // set stroke color and alpha
	d1.fill(#FF6600);        // set fill color
	d1.anchorAt(H.CENTER);   // set where anchor point is / key point for rotation and positioning
	d1.rotation(45);         // set rotation of the rect
	d1.loc(m*1, h);   // set x and y location

	// here's the same code / with method chaining

	d2 = new HRect(100);
	d2
		.rounding(10)
		.strokeWeight(6)
		.stroke(#000000, 150)
		.fill(#FF9900)
		.anchorAt(H.CENTER)
		.rotation(45)
		.loc(m*2, h)
	;

	// here's the same code / minus the hard returns and tabbing

	d3 = new HRect();
	d3.rounding(10).strokeWeight(6).stroke(#000000, 150).fill(#FFCC00).anchorAt(H.CENTER).rotation(45).loc(m*3, h);
}

void draw() {
	background(clrBg);

	d1.draw(this.g); // object.draw(where to draw) / this.g refers to processing stage
	d2.draw(this.g);
	d3.draw(this.g);

	// here is the non HYPE version / basic processing syntax

	pushMatrix();
		strokeWeight(6);
		stroke(#000000, 150);
		fill(#FF3300);
		translate(m*4, h);
		rotate( radians(45) );
		rect(0, 0, 100, 100, 10, 10, 10, 10);
	popMatrix();

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

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
