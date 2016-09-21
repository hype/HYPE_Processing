/*
	Example showing full methods for the Fibonacci Spiral layout
	Larger sized pools show the spirals off more
*/

import hype.*;
import hype.extended.layout.HSphereLayout;

HDrawablePool     pool;
HSphereLayout     layout;

void setup() {
	size(640, 640, P3D); 
	H.init(this).background(#151515).use3D(true);
	smooth();

	pool = new HDrawablePool(300);

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(200)
		.rotate(true);

	//Fibonacci Spiral specific methods
	layout.useSpiral() //tells layout to use the Fibonacci spiral layout calculations
		.numPoints(300) //how many points to plot on the sphere. This can be the same number as objects in your pool
	;

	/*
		The phiModifier method is the secret sauce for this layout.
		It's the magic number that modifies the multiplication of the calculated angle.
		Vary it as much as you like to get different degrees of spiral gradations.
	*/
	// layout.phiModifier(7.2);
	// layout.phiModifier(1.2345);
	// layout.phiModifier(3.0001);
	// layout.phiModifier(0.805);
	
	pool.add(new HBox())
		.layout(layout)
		.autoAddToStage()
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.depth(10);
					d.size(10, 10);
					d.noStroke();
				}
			}
		)
		.requestAll();
}

void draw() {

	if (mousePressed) {
		translate(width/2, height/2);
		rotateX(map(mouseY, 0, height, -(TWO_PI / 2), TWO_PI/2));
		rotateY(map(mouseX, 0, width, -(TWO_PI / 2), TWO_PI/2));
		translate(-width/2, -height/2);
	}

	lights();

	H.drawStage();
} 
