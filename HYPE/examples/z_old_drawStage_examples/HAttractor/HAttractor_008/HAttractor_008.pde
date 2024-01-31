import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HAttractor;

HDrawablePool pool;
HAttractor    ha;

float r = 0;

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#242424).use3D(true);

	ha = new HAttractor().repelMode().debugMode(true);

	ha.addForce(94,   94, -225, 200);
	ha.addForce(540,  94, -225, 200);
	ha.addForce(94,  540, -225, 200);
	ha.addForce(540, 540, -225, 200);

	ha.addForce(94,   94,  225, 200);
	ha.addForce(540,  94,  225, 200);
	ha.addForce(94,  540,  225, 200);
	ha.addForce(540, 540,  225, 200);

	pool = new HDrawablePool(3375);
	pool.autoAddToStage()
		.add(new HBox().depth(5).width(5).height(5))
		.layout(new HGridLayout().startX(95).startY(95).startZ(-225).spacing(30, 30, 30).cols(15).rows(15))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(#ECECEC).anchorAt(H.CENTER);

					ha.addTarget(d, 20, 0.5f);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	lights();

	translate( width/2,  height/2);
	rotateY( radians(r) );
	translate(-width/2, -height/2);
	r+=0.4;

	H.drawStage();
}
