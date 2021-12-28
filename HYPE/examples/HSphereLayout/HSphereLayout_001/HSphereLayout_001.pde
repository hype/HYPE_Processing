import hype.*;
import hype.extended.layout.HSphereLayout;

HDrawablePool pool;
HSphereLayout layout;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true);

	// Most basic default HSphereLayout

	layout = new HSphereLayout(width/2, height/2, 0);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HBox())
		.layout(layout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.size(10).noStroke();
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
