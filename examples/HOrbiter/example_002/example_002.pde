void setup() {
	size(640, 640);
	H.init(this).background(#202020);
	smooth();

	HRect r = new HRect(40);
	r
		.rounding(10)
		.anchorAt(H.CENTER)
		.fill(#FFFFFF)
		.noStroke()
	;
	H.add(r);

	HOrbiter o = new HOrbiter(width/2, height/2)
		.target(r)
		.speed(.25)
		.radius(250)
	;


	HRect r2 = new HRect(20);
	r2
		.rounding(10)
		.anchorAt(H.CENTER)
		.fill(#FF3300)
		.noStroke()
	;
	H.add(r2);

	HOrbiter o2 = new HOrbiter()
		.target(r2)
		.speed(3.3)
		.radius(60)
		.rotateTarget(true)
		.parent(o)
	;
}

void draw() {
	H.drawStage();
}