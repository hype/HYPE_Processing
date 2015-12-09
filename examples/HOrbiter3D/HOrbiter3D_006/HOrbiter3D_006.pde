import hype.*;
import hype.extended.behavior.HOrbiter3D;

HOrbiter3D orb1, orb2;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	HRect d = new HRect(50).rounding(4);
	d.noStroke().fill(#FF3300).anchorAt(H.CENTER).rotation(45);
	H.add(d);

	orb1 = new HOrbiter3D(width/2, height/2, 0)
		.zSpeed(-1)
		.radius(200)
	;

	orb2 = new HOrbiter3D(width/2, height/2, 0)
		.target(d)
		.zSpeed(5)
		.radius(75)
		.parent(orb1)
	;
}

void draw() {
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
