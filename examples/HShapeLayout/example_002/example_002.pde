HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	HEllipse hitObj = new HEllipse(200);
	H.add(hitObj).noStroke().fill(#237D26).anchorAt(H.CENTER).locAt(H.CENTER);

	HShapeLayout hsl = new HShapeLayout().target(hitObj);
	
	pool = new HDrawablePool(200);
	pool.autoAddToStage()
		.add (
			new HRect().rounding(5)
		)

		.colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly() )

		.layout(hsl)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.size( 5+((int)random(10)*5) )
						.anchorAt(H.CENTER)
						.rotation(45)
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

