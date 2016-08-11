import hype.*;
import hype.extended.behavior.HOscillator;

HDrawablePool pool;
int           boxSize = 500;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool(1);
	pool.autoAddToStage()
		.add(new HBox().texture("tex.png"))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HBox d = (HBox) obj;
					d.depth(boxSize).width(boxSize).height(boxSize).strokeWeight(2).stroke(0,225).fill(255,225).x(width/2).y(height/2).z(-500);

					new HOscillator().target(d).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(1).currentStep(i);
					new HOscillator().target(d).property(H.ROTATIONY).range(-360, 360).speed(0.2).freq(1).currentStep(i);
					new HOscillator().target(d).property(H.ROTATIONZ).range(-360, 360).speed(0.3).freq(1).currentStep(i);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	/*
		Be wary when using these hints, they are there to help with z depth clipping issues.
		They can have performance issues when there's a lot of overlapping objects on screen.
	*/
	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	lights();
	H.drawStage();
}
