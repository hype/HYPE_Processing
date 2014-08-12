/* @pjs preload="theAmericas.png"; */

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	HImage hitObj = new HImage("theAmericas.png");
	H.add(hitObj);

	HShapeLayout hsl = new HShapeLayout().target(hitObj);
	
	pool = new HDrawablePool(200);
	pool.autoAddToStage()
		.add (
			new HRect().rounding(5)
		)

		.colorist( new HColorPool(#CCE70B, #80C41C, #40A629, #237D26, #FF3300, #FF6600).fillOnly() )

		.layout(hsl)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.size( 5+((int)random(5)*5) )
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

