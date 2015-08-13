HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	pool = new HDrawablePool(121);
	pool.autoAddToStage()
		.add (
			new HShape("art_06.svg")
			.enableStyle(false)
			.strokeJoin(CENTER)
			.strokeCap(CENTER)
			.anchorAt(H.CENTER)
		)

		.layout (
			new HGridLayout()
			.startX(70)
			.startY(70)
			.spacing(50,50)
			.cols(11)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.fill( #242424 )
						.strokeWeight(1)
						.stroke( #999999 )
						.rotation( ((int)random(4)) * 90 )
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

