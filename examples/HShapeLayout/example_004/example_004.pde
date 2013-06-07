/* @pjs font="DroidSerifBold.ttf"; */

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	// type size of "60" and .size(300) acting odd / will chat on wednesday

	PFont type = createFont("DroidSerifBold.ttf", 60);
	HText hitObj = new HText( "Hi", 60, type );
	H.add(hitObj).size(300).noStroke().fill(#237D26).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);

	HShapeLayout hsl = new HShapeLayout().target(hitObj);

	pool = new HDrawablePool(3000);
	pool.autoAddToStage()
		.add (
			new HRect(4).rounding(2)
		)

		.colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly() )

		.layout(hsl)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
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

