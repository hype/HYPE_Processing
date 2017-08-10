import hype.*;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
int           boxSize = 64;
HCanvas canvas;


void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	canvas = new HCanvas(P3D);
	canvas.lights();
  H.add(canvas);


	pool = new HDrawablePool(100);
	pool.autoParent(canvas)
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
	H.drawStage();
}