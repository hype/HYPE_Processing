HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(5)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.fill(#242424)
						.strokeWeight(1)
						.stroke(#999999)
						.loc( (int)random(width), (int)random(height) )
						.anchorAt(H.CENTER)
						.rotation( 45 )
						.size(50)
					;
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {}

