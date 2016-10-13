import hype.*;
import hype.extended.layout.HSphereLayout;

HDrawablePool pool;
HSphereLayout layout;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true);

	// Example showing basic methods for the Proportional sin(phi) layout

	layout = new HSphereLayout().loc(width/2, height/2, 0).radius(200).rotate(true);

	// Proportional sin(phi) specific methods

	layout.useProportional() // tells layout to use the proportional spacing calculations
		.detail(13)          // equivalent to number of rows to display
		// .offsetRows(true) // layout also supports offsetRows as seen in example 3
	;
	
	pool = new HDrawablePool(320);
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
