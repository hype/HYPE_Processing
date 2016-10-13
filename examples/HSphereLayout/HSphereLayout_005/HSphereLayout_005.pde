import hype.*;
import hype.extended.layout.HSphereLayout;

HDrawablePool pool;
HSphereLayout layout;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true);

	// Example showing full methods for the UVSphere

	layout = new HSphereLayout().loc(width/2, height/2, 0).radius(200).rotate(true);

	// UVSphere specific methods

	layout.useUV()           // tells layout to use the UV calculation of points
		.cols(5)             // how many columns to split the sphere into
		.rows(25)            // how many rows to split the sphere into
		.ignorePoles()       // avoid placing objects at the sphere's poles to avoid bunching
		// .offsetRows(true) // adding this will appear to double the number of cols as it offsets the even rows by half of the row spacing
	;

	pool = new HDrawablePool(125);
	pool.autoAddToStage()
		.add(new HBox())
		.layout(layout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.size(10).depth(40).noStroke();
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	if (mousePressed) {
		translate(width/2, height/2);
		rotateX(map(mouseY, 0, height, -(TWO_PI/2), TWO_PI/2));
		rotateY(map(mouseX, 0, width,  -(TWO_PI/2), TWO_PI/2));
		translate(-width/2, -height/2);
	}

	lights();
	H.drawStage();
}
