import hype.*;
import hype.extended.behavior.HOrbiter3D;

HOrbiter3D orb;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	orb = new HOrbiter3D(width/2, height/2, 0)
		.zSpeed(1.5)
		.ySpeed(0.2)
		.radius(250)
	;
}

void draw() {
	background(#242424);

	orb._run();
	PVector pt = orb.getNextPoint();
	
	//simple sphere mesh to show orbit range
	pushMatrix();
		translate(width/2, height/2, 0);
		stroke(#666666);
		noFill();
		sphereDetail(20);
		sphere(200);
	popMatrix();

	//draw a line from current orbit point to next orbit point
	stroke(#ff3300);
	beginShape(LINES);
		vertex(orb.x(), orb.y(), orb.z());
		vertex(pt.x, pt.y, pt.z);
	endShape();


}
