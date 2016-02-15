import hype.*;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool(125);
	pool.autoAddToStage()
		.add(new HBox())

		.layout(
			new HGridLayout()
			.startX(180)
			.startY(180)
			.startZ(-140)
			.spacing(70, 70, 70)
			.cols(5)
			.rows(5)
		)

		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HBox d = (HBox) obj;
					d.depth(25).width(25).height(25);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	lights();

	translate( width/2,  height/2);
	rotateY( map(mouseX, 0, width, -(TWO_PI/2), TWO_PI/2) );
	translate(-width/2, -height/2);

	H.drawStage();
}
