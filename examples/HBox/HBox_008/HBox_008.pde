import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HRotate;
import hype.extended.behavior.HOscillator;

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
					int i = pool.currentIndex();
					HBox d = (HBox) obj;
					d.depth(boxSize).width(boxSize).height(boxSize).noStroke().z(-500).rotationX(45).rotationY(45);

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0.5, 1.5)
						.speed(1)
						.freq(2)
						.currentStep(i*3)
					;
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

	translate(width/2, height/2, -500);
	rotateX(map(mouseY, 0, height, -(TWO_PI / 2), TWO_PI/2));
	rotateY(map(mouseX, 0, width,  -(TWO_PI / 2), TWO_PI/2));
	translate(-width/2, -height/2, 500);

	H.drawStage();
}
