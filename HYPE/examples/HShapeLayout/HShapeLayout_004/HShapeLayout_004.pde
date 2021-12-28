import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HShapeLayout;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	// type size of "60" and .size(300) acting odd / better to use trans .PNG for type

	PFont type = createFont("DroidSerifBold.ttf", 60);
	HText hitShape = new HText( "Hi", 60, type );
	H.add(hitShape).size(300).noStroke().fill(#237D26).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);

	HShapeLayout hsl = new HShapeLayout().target(hitShape);

	pool = new HDrawablePool(3000);
	pool.autoAddToStage()
		.add(new HRect(4).rounding(2))
		.colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly() )
		.layout(hsl)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().anchorAt(H.CENTER).rotation(45);
				}
			}
		)
		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {

}
