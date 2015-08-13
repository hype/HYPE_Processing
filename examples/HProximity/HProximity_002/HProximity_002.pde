import hype.*;

void setup() {
	size(640, 640);
	H.init(this).background(#202020);

	HDrawablePool pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add(
			new HRect()
			.rounding(4)
			.noStroke()
			.fill(#ECECEC)
			.size(25)
			.anchorAt(H.CENTER)
		)

		.layout(
			new HGridLayout()
				.startLoc(21, 21)
				.spacing(26, 26)
				.cols(24)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
            		
            		new HProximity()
            			.target(d)
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
