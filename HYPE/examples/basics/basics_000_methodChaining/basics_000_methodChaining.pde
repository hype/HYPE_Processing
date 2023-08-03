import hype.*;

int   stageW = 640;
int   stageH = 640;
color clrBg  = #242424;

// **************************************************

HRect s1, s2, s3;

void settings() {
	size(stageW, stageH, P3D);
}

void setup() {
	H.init(this);
	background(clrBg);

	s1 = new HRect(100);     // create a new HRect object and size
	s1.rounding(10);         // set corner rounding
	s1.strokeWeight(6);      // set stroke weight
	s1.stroke(#000000, 150); // set stroke color and alpha
	s1.fill(#FF6600);        // set fill color
	s1.anchorAt(H.CENTER);   // set where anchor point is / key point for rotation and positioning
	s1.rotation(45);         // set rotation of the rect
	s1.loc(100, height/2);   // set x and y location

	// here's the same code / with method chaining

	s2 = new HRect(100);
	s2
		.rounding(10)
		.strokeWeight(6)
		.stroke(#000000, 150)
		.fill(#FF9900)
		.anchorAt(H.CENTER)
		.rotation(45)
		.loc(247, height/2)
	;

	// here's the same code / minus the hard returns and tabbing

	s3 = new HRect(100);
	s3.rounding(10).strokeWeight(6).stroke(#000000, 150).fill(#FFCC00).anchorAt(H.CENTER).rotation(45).loc(394, height/2);
}

void draw() {
	background(clrBg);

	strokeWeight(1);
	stroke(#0095a8);
	line(0, height/2, width, height/2);

	s1.draw(this.g); // object.draw(where to draw) / this.g refers to processing stage
	s2.draw(this.g);
	s3.draw(this.g);

	// here is the non HYPE version / basic processing syntax

	pushMatrix();
		strokeWeight(6);
		stroke(#000000, 150);
		fill(#FF3300);
		translate(width - 100, (height / 2));
		rotate( radians(45) );
		rect(0, 0, 100, 100, 10, 10, 10, 10);
	popMatrix();
}
