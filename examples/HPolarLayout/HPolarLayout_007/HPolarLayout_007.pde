import hype.*;
import hype.extended.layout.HPolarLayout;
import hype.extended.behavior.HOscillator;

HDrawablePool pool;

int           colshifter = 0;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HPolarLayout layout = new HPolarLayout(0.25, 10).offset(width/2, height/2).scale(0.005);

	pool = new HDrawablePool(1100);
	pool.autoAddToStage()
		.add(new HRect(10).rounding(3))
		.layout(layout)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(#FFFFFF).anchorAt(H.CENTER);

					new HOscillator().target(d).property(H.SCALE).range(0.1, 2).speed(2).freq(1).currentStep(i);
					new HOscillator().target(d).property(H.ROTATION).range(-180, 180).speed(0.5).freq(1).currentStep(i);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	colorMode(HSB, 360, 100, 100);

	colshifter++;
	if (colshifter >360) colshifter=0;

	for (HDrawable d : pool) {
		color tempClr = color(colshifter, random(50, 100), random(75, 100));
		d.fill( tempClr );
	}

	H.drawStage();
}
