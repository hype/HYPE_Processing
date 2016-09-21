/*
	Default HSphereLayout with increased radius and avoiding poles (top and bottom of the sphere)
*/

import hype.*;
import hype.extended.layout.HSphereLayout;

HDrawablePool     pool;
HSphereLayout     layout;

void setup() {
	size(640, 640, P3D); 
	H.init(this).background(#151515).use3D(true);
	smooth();

	pool = new HDrawablePool(100);

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(200)
		.ignorePoles();
	
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
