HDrawablePool pool;
PImage img;

void setup() {
	noLoop();
	size(500, 500);
	H.init(this).background(#202020);
	smooth();

	final HPixelColorist colors = new HPixelColorist("lovehotels.jpg").fillOnly();

	img = loadImage("lovehotels.jpg");

	pool = new HDrawablePool(2500);
	pool.autoAddToStage()
		.add(
			new HRect(20, 5)
				.rounding(2)
				.anchorAt(H.CENTER)
				.noStroke()
		)

		.layout(
			new HGridLayout()
				.startLoc(5, 5)
				.spacing(10, 10)
				.cols(50)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					new HColorLightness(img)
						.property(H.ROTATION)
						.range(0, 90)
						.target(d)
					;

					colors.applyColor(d);
					
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
}

void draw() {
}

