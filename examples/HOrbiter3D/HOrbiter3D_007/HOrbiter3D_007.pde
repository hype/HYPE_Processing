import hype.*;
import hype.extended.behavior.HOrbiter3D;

HOrbiter3D orb1, orb2;
HCanvas    canvas;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	canvas = new HCanvas(P3D).autoClear(false).fade(1);
	H.add(canvas);

	HRect d = new HRect(50).rounding(4);
	d.noStroke().fill(#FF3300).anchorAt(H.CENTER).rotation(45);
	canvas.add(d);

	orb1 = new HOrbiter3D(width/2, height/2, 0)
		.zSpeed(-1.5)
		.ySpeed(-0.2)
		.radius(200)
	;

	orb2 = new HOrbiter3D(width/2, height/2, 0)
		.target(d)
		.zSpeed(5)
		.ySpeed(2)
		.radius(75)
		.parent(orb1)
	;
}

void draw() {
	// hint(DISABLE_DEPTH_TEST);
	H.drawStage();

	//simple sphere mesh to show orbit range
	pushMatrix();
		translate(width/2, height/2, 0);
		stroke(#333333);
		noFill();
		sphereDetail(20);
		sphere(200);
	popMatrix();

	pushMatrix();
		translate(orb1.x(), orb1.y(), orb1.z());
		stroke(#4D4D4D);
		noFill();
		sphereDetail(20);
		sphere(75);
	popMatrix();
}
