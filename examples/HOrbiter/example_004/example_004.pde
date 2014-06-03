void setup() {
	size(640, 640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	HColorPool c = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	HRect r = new HRect(10);
	r
		.rounding(10)
		.anchorAt(H.CENTER)
		.fill(c.getColor())
		.noStroke()
	;
	H.add(r);

	HOrbiter o = new HOrbiter()
		.target(r)
		.speed(4)
		.radius(50)
		.parent(
			new HOrbiter(width/2, height/2).speed(0.3).radius(200)
		)
	;
}

void draw() {
	H.drawStage();
}