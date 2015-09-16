import hype.*;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool(75);
	pool.autoAddToStage()
		.add(new HBox())

		.layout(
			new HGridLayout()
			.startX(120)
			.startY(120)
			.startZ(0)
			.spacing(100, 100, 50)
			.cols(5)
			.rows(5)
		)

		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HBox d = (HBox) obj;
					d.depth(50).width(50).height(50);

					if (d.z() > 0)  d.fill(#FF6600);
					if (d.z() > 50) d.fill(#EEBB00);
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
