/*
	Example showing full methods for the UVSphere
*/

import hype.*;
import hype.extended.layout.HSphereLayout;

HDrawablePool     pool;
HSphereLayout     layout;

void setup() {
	size(640, 640, P3D); 
	H.init(this).background(#151515).use3D(true);
	smooth();

	pool = new HDrawablePool(125);

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(200)
		.rotate(true);

	//UVSphere specific methods
	layout.useUV() //tells layout to use the UV calculation of points
		.cols(5) //how many columns to split the sphere into
		.rows(25) //how many rows to split the sphere into
		.ignorePoles() //avoid placing objects at the sphere's poles to avoid bunching
		//.offsetRows(true) //adding this will appear to double the number of cols as it offsets the even rows by half of the row spacing
	;
	
	pool.add(new HBox())
		.layout(layout)
		.autoAddToStage()
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.depth(40);
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
