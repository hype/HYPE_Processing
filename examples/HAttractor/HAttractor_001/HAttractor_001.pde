import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HAttractor;

HDrawablePool pool;
HAttractor    ha;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	ha = new HAttractor(320, 320, 200) // x, y, radius
		.debugMode(true)
	;

	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add(new HRect(25).rounding(4))
		.layout(new HGridLayout().startX(21).startY(21).spacing(26,26).cols(24))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(#ECECEC).anchorAt(H.CENTER);

					ha.addTarget(d, 10, 0.1f); // target drawable(s), maxspeed, maxforce
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
