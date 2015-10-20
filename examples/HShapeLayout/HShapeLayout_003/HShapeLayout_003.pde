import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HShapeLayout;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HPath hitShape = new HPath().star( 5, 0.5, -90 );
	H.add(hitShape).size(400).noStroke().fill(#237D26).anchorAt(H.CENTER).locAt(H.CENTER);

	HShapeLayout hsl = new HShapeLayout().target(hitShape);
	
	pool = new HDrawablePool(300);
	pool.autoAddToStage()
		.add(new HRect().rounding(5))
		.colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly() )
		.layout(hsl)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().size( 5+((int)random(5)*5) ).anchorAt(H.CENTER).rotation(45);
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
