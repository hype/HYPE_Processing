import hype.*;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
HImage i1;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);
	lights();

	i1 = new HImage("texture.png");

	HBox b = new HBox();
	b.texture(i1);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(b)
		.layout(new HGridLayout().startX(-125).startY(-125).spacing(100,100).cols(10))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HBox d = (HBox) obj;
					d
						.depth(64) // depth is a 3D/HBox specific method, so put this first
						.width(64)
						.height(64)
						.z(-500)
						.rotationZ(33)
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

