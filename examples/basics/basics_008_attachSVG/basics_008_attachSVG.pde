import hype.*;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool(121);
	pool.autoAddToStage()
		.add(
			new HShape("art6.svg")
			.enableStyle(false)
			.strokeJoin(CENTER)
			.strokeCap(CENTER)
			.anchorAt(H.CENTER)
		)

		.layout(
			new HGridLayout()
			.startX(70)
			.startY(70)
			.spacing(50,50)
			.cols(11)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.stroke(#999999)
						.fill(#242424)
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

void draw() {

}
