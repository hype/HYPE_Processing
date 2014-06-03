void setup() {
	size(640, 640);
	H.init(this).background(#202020);
	smooth();

	HRect r = new HRect(60);
	r
		.rounding(10)
		.anchorAt(H.CENTER)
		.fill(255)
		.noStroke()
	;
	H.add(r);

	HOrbiter o = new HOrbiter(width/2, height/2)
		.target(r)
		.speed(0.75)
		.radius(250)
	;
}

void draw() {
	H.drawStage();
}