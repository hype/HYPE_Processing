import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HAttractor;

HDrawablePool pool;
HAttractor    ha;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	ha = new HAttractor().debugMode(true);
	ha.addForce(320, 180, 150);
	ha.addForce(160, 460, 150);
	ha.addForce(480, 460, 150);

	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add(new HRect(25).rounding(4))
		.layout(new HGridLayout().startX(21).startY(21).spacing(26,26).cols(24))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(#ECECEC).anchorAt(H.CENTER);

					ha.addTarget(d, 10, 0.1f);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
