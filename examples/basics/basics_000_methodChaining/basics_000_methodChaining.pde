import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HRect rect1 = new HRect(100);
	rect1.rounding(10);         // set corner rounding
	rect1.strokeWeight(6);      // set stroke weight
	rect1.stroke(#000000, 150); // set stroke color and alpha
	rect1.fill(#FF6600);        // set fill color
	rect1.anchorAt(H.CENTER);   // set where anchor point is / key point for rotation and positioning
	rect1.rotation(45);         // set rotation of the rect
	rect1.loc(100,height / 2);  // set x and y location
	H.add(rect1); 

	// here's the same code / with method chaining

	HRect rect2 = new HRect(100);
	rect2
		.rounding(10)
		.strokeWeight(6)
		.stroke(#000000, 150)
		.fill(#FF9900)
		.anchorAt(H.CENTER)
		.rotation(45)
		.loc(247,height / 2)
	;
	H.add(rect2);

	// here's the same code / minus the hard returns and tabbing

	HRect rect3 = new HRect(100);
	rect3.rounding(10).strokeWeight(6).stroke(#000000, 150).fill(#FFCC00).anchorAt(H.CENTER).rotation(45).loc(394,height / 2);
	H.add(rect3);

	H.drawStage(); // paint the stage

	// here is the non HYPE version / basic processing syntax

	pushMatrix();
		strokeWeight(6);
		stroke(#000000, 150);
		fill(#FF3300);
		translate(width - 100, (height / 2));
		rotate( radians(45) );
		rect(0, 0, 100, 100, 10, 10, 10, 10);
	popMatrix();

	/*

	thoughts : well in the processing version you'd have to use push and pop
	matrix to perform the rotation and positioning. I find this difficult to explain
	to designers that you're not rotating the rect but the entire stage.

	not having the ability to adjust an "anchor" position means we have to calculate
	the rect's y coordinate to get it centered so trying to subract half of the rect's height

	translate(width - 100, (height / 2) - 50); // nope still doesn't center

	this is because a 100 x 100 rectangle rotated 45 degrees now sits at 141 x 141 (approx)
	this would mean we'd have to offset like so :

	translate(width - 100, (height / 2) - 70.5);

	*/

	// draw where the horiz line is

	strokeWeight(1);
	stroke(#0095a8);
	line(0, height/2, width, height/2);

	noLoop();
}

void draw() {

}
