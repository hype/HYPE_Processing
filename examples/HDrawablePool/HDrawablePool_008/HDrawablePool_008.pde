/*
	Visually the same as example_007, this demonstrates that shuffleRequestAll
	now supports autoParent and not just the stage as it did previously
*/
HDrawablePool pool;
HCanvas canvas;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	canvas = new HCanvas();
	H.add(canvas);

	pool = new HDrawablePool(100);
	pool.autoParent(canvas)
		.add (
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
