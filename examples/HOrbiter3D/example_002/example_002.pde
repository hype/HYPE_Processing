void setup() {
	size(640, 640, P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();
	lights();

	HRect r = new HRect();
	r
		.rounding(4)
		.anchorAt(H.CENTER)
		.fill(#FF4400)
		.noStroke()
		.rotation(45)
		.size(45)
	;
	H.add(r);

	HOrbiter3D o = new HOrbiter3D(width/2, height/2, 0)
		.target(r)
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
