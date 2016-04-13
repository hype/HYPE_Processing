import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HRotate;

HDrawablePool pool;

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
					int ranSize = 25 + ( (int)random(5)*25 );
					
					HBox d = (HBox) obj;
					d.depth(ranSize).width(ranSize).height(ranSize).noStroke().z( (int)random(-600, 0) );

					HRotate r = new HRotate();
					r.target(d).speed( random(-4,4) );
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
