import hype.*;
import hype.extended.layout.HSphereLayout;

HDrawablePool pool;
HSphereLayout layout;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true);

	// Default HSphereLayout handling larger pools than the layout allows for
	// The default behavior here is to increase the radius by itself
	// i.e. a radius of 100 would increase by 100 each time the layout is filled
	// Full set of extending methods are shown below. Comment each one out to try them.

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(100)
		.ignorePoles()
		.offsetRows(true)
		.rotate(true)
		// .extendRadius(50)         // extend the layout by increasing the radius by the arg passed in
		// .extendNegativeRadius(50) // extend the layout by decreasing the radius by the arg passed in
		// .extendX()                // extend the center of the layout (x position) by 2x radius to the right
		// .extendNegativeX()        // extend the center of the layout (x position) by 2x radius to the left
		// .extendY()                // extend the center of the layout (y position) by 2x radius downward
		// .extendNegativeY()        // extend the center of the layout (y position) by 2x radius upward
		// .extendZ()                // extend the center of the layout (z position) by 2x radius forward
		// .extendNegativeZ()        // extend the center of the layout (z position) by 2x radius backward
	;

	// You also have the option to utilise HYPE constants to set the layout extension if you prefer

	// layout.setExtension(H.RADIUS);
	// layout.setExtension(H.X);
	// layout.setExtension(H.Y);
	// layout.setExtension(H.Z);
	// layout.setExtension(-H.X);
	// layout.setExtension(-H.Y);
	// layout.setExtension(-H.Z);

	pool = new HDrawablePool(200); // note pool size is 200
	pool.autoAddToStage()
		.add(new HBox())
		.layout(layout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.size(10).depth(50).noStroke();

					// orange fill on the objects that are indexed 100+
					if (pool.currentIndex() > 99) d.fill(#ff3300);
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
