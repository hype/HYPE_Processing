void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	HRect r = new HRect(100);
	r
		.rounding(10)
		.noStroke()
		.fill(255, 51, 0)
		.loc(width/3,height/3)
	;
	H.add(r);

	HVector initialVelocityVector = new HVector(1, 1);
	HVelocity initialVelocity = new HVelocity().velocity(initialVelocityVector).target(r);

	HVector accelVector = new HVector(-0.005, -0.005);
	HVelocity acceleration = new HVelocity().accel(accelVector).target(r);
}

void draw() {
	H.drawStage();
}

