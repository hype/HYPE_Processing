HDrawablePool pool;
HColorPool colors;
HCanvas canvas;

void setup() {
	size(640, 640);
	H.init(this).background(#202020);
	smooth();

	canvas = new HCanvas().autoClear(false).fade(5);
	H.add(canvas);

	colors = new HColorPool(#FFFFFF, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	pool = new HDrawablePool(42);
	pool.autoParent(canvas)

		.add(
			new HRect(1, 500)
				.rounding(10)
				.anchorAt(H.CENTER)
				.noStroke()
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					d.fill(colors.getColor());

					float r = floor(random(10, 31)) * 10;

					new HOrbiter(width/2, height/2)
						.target(d)
						.speed(random(.5, 1.5))
						.radius(r)
						.startAngle(random(360))
					;
					
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	H.drawStage();
}