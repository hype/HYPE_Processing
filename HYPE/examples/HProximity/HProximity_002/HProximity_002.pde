import hype.*;
import hype.extended.behavior.HProximity;
import hype.extended.layout.HGridLayout;

void setup() {
	size(640, 640);
	H.init(this).background(#242424);

	HDrawablePool pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add(new HRect(25).rounding(4).noStroke().fill(#ECECEC).anchorAt(H.CENTER))
		.layout(new HGridLayout().startLoc(21, 21).spacing(26, 26).cols(24))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					new HProximity().target(d);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
