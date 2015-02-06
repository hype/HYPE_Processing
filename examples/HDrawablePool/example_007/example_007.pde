HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	pool = new HDrawablePool(100);
	pool.add (
			new HRect()
			.rounding(5)
			.stroke(0)
			.fill(255)
			.anchorAt(H.CENTER)
			.rotation(45)
			.size(70)
		)
		.layout (
			new HGridLayout()
			.startX(32)
			.startY(32)
			.spacing(64,64)
			.cols(10)
		)

		.shuffleRequestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {}
