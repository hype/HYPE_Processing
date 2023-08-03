import hype.*;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
int           boxSize = 64;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HBox())
		.layout(new HGridLayout().startX(-125).startY(-125).spacing(100,100).cols(10))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HBox d = (HBox) obj;
					d.depth(boxSize).width(boxSize).height(boxSize).noStroke().z(-500).rotationZ(33);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	pointLight(255,  51,   0,        0, height/2, -300); // orange
	pointLight(0,   149, 168,    width, height/2, -300); // teal
	pointLight(255, 204,   0,  width/2, height/2, -400); // yellow

	H.drawStage();
}
