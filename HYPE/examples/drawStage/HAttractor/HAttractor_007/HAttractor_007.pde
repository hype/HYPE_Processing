import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HAttractor;

HDrawablePool pool;
HAttractor    ha;
HAttractor.HAttractionForce hf;

float r = 0;
float a = 0;

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#242424).use3D(true);

	ha = new HAttractor(320, 320, 100, 260).debugMode(true);
	hf = ha.getForce(0);

	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add(new HBox().depth(10).width(10).height(10))
		.layout(new HGridLayout().startX(26).startY(26).startZ(0).spacing(26, 26, 26).cols(24).rows(24))
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

	float x = 320 + cos(radians(a)) * 200;
	float y = 320 + sin(radians(a)) * 200;
	a += 1.0f/1.4;
	hf.loc(x, y, 100);

	translate( width/2,  height/2);
	rotateY( radians(r) );
	translate(-width/2, -height/2);
	r+=0.4;

	H.drawStage();
}
