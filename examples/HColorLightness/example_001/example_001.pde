HDrawablePool pool;
PImage img;

void setup() {
	noLoop();
	size(500, 500);
	H.init(this).background(#202020);
	smooth();

	img = loadImage("testplate.png");

	pool = new HDrawablePool(750);
	pool.autoAddToStage()
		.add(
			new HRect(10, 10)
				.rounding(5)
				.anchorAt(H.CENTER)
				.noStroke()
				.fill(255)
		)

		.layout(
			new HGridLayout()
				.startLoc(10, 10)
				.spacing(20, 20)
				.cols(25)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					/*
						When using HColorLightness in a pool, it is more efficient to pass an instance of a PImage
						than to pass a file name.

						Passing the filename to the behaviour when using a pool results in much slower loading/running 
						as loadImage is called for every object in the pool i.e. new HColorLightness("testplate.png")
					*/

					new HColorLightness(img)
						.property(H.SCALE)
						.range(0, 1)
						.target(d)
					;
					
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
}

void draw() {
}

