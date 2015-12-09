import hype.*;
import hype.extended.behavior.HOrbiter3D;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	HRect d = new HRect(50).rounding(4);
	d.noStroke().fill(#FF3300).anchorAt(H.CENTER).rotation(45);
	H.add(d);

	HOrbiter3D orb = new HOrbiter3D(width/2, height/2, 0)
		.target(d)
		.zSpeed(1.5)
		.ySpeed(0.2)
		.radius(250)
	;
}

void draw() {
	H.drawStage();

	//simple sphere mesh to show orbit range
	pushMatrix();
		translate(width/2, height/2, 0);
		stroke(#666666);
		noFill();
		sphereDetail(20);
		sphere(200);
	popMatrix();
}
