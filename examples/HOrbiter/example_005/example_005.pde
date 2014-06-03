void setup() {
	size(640, 640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	HColorPool c = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #0095A8, #FF3300, #FF6600);

	HRect r = new HRect(10);
	r
		.rounding(10)
		.anchorAt(H.CENTER)
		.noStroke()
		.fill(c.getColor())
	;

	H.add(r);

	HOrbiter o = new HOrbiter()
		.target(r)
		.speed(16)
		.radius(20)
		.parent(
			new HOrbiter().speed(4).radius(50).parent(
				new HOrbiter(width/2, height/2).speed(1).radius(200)
			)
		)
	;
}

void draw() {
	H.drawStage();
}