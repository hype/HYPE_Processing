void setup() {
	size(640, 640, P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();
	lights();

	HBox b = new HBox();
	b.depth(40).height(40).width(40).fill(#FF4400);
	H.add(b);

	HOrbiter3D o = new HOrbiter3D(width/2, height/2, 0)
		.target(b)
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
		noFill();
		stroke(255);
		sphereDetail(20);
		sphere(200);
	popMatrix();

}
