import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HShapeLayout;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HImage hitShape = new HImage("theAmericas.png");
	H.add(hitShape);

	HShapeLayout hsl = new HShapeLayout().target(hitShape);
	
	pool = new HDrawablePool(200);
	pool.autoAddToStage()
		.add(new HRect().rounding(5))
		.colorist( new HColorPool(#CCE70B, #80C41C, #40A629, #237D26, #FF3300, #FF6600).fillOnly() )
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
