import hype.*;

// This test file demonstrates the feature for transforming children whenever the parent is resized.

HGroup grp;
HRect  r1, r2;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	// By default, most drawables won't transform their children.

	r1 = H.add(new HRect().rounding(5));
	r1.noStroke().fill(#FF3300);

	// To set it on,  call transformsChildren(true).
	// To set it off, call transformsChildren(false).

	r2 = H.add(new HRect().rounding(5));
	r2.noStroke().fill(#FF6600).x(width/3).transformsChildren(true);

	// The exception to this is HGroup, which is by default would transform its children.
	// You can turn this off with transformsChildren(false)

	grp = H.add(new HGroup());
	grp.x(width*2/3);
	// grp.transformsChildren(false);

	r1.add(new HEllipse(5)).noStroke().fill(#0095a8);
	r1.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.TOP_RIGHT).locAt(H.TOP_RIGHT);
	r1.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.CENTER).locAt(H.CENTER);
	r1.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.BOTTOM_RIGHT).locAt(H.BOTTOM_RIGHT);
	r1.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.BOTTOM_LEFT).locAt(H.BOTTOM_LEFT);

	r2.add(new HEllipse(5)).noStroke().fill(#0095a8);
	r2.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.TOP_RIGHT).locAt(H.TOP_RIGHT);
	r2.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.CENTER).locAt(H.CENTER);
	r2.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.BOTTOM_RIGHT).locAt(H.BOTTOM_RIGHT);
	r2.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.BOTTOM_LEFT).locAt(H.BOTTOM_LEFT);

	grp.add(new HEllipse(5)).noStroke().fill(#0095a8);
	grp.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.TOP_RIGHT).locAt(H.TOP_RIGHT);
	grp.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.CENTER).locAt(H.CENTER);
	grp.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.BOTTOM_RIGHT).locAt(H.BOTTOM_RIGHT);
	grp.add(new HEllipse(5)).noStroke().fill(#0095a8).anchorAt(H.BOTTOM_LEFT).locAt(H.BOTTOM_LEFT);

	H.add(new HText("transformsChildren(false)",14)).anchorAt(H.CENTER).loc(100, height-40).fill(#CCCCCC);
	H.add(new HText("transformsChildren(true)",14)).anchorAt(H.CENTER).loc(width/2, height-40).fill(#CCCCCC);
	H.add(new HText("HGroup default",14)).anchorAt(H.CENTER).loc(width - 108, height-40).fill(#CCCCCC);
}

void draw() {
	if(H.mouseStarted()) {
		float w = max(10, mouseX/3);
		float h = max(10, mouseY);
		r1.size(w,h);
		r2.size(w,h);
		grp.size(w,h);
	}

	H.drawStage();
}
