import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
HColorPool    colors;
HCanvas       canvas;

void setup() {
	size(640,640);
	H.init(this).background(#111111);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	canvas = H.add(new HCanvas()).autoClear(false).fade(10);

	pool = new HDrawablePool(400);
	pool.autoParent(canvas)
		.add(new HPath().star(5, 0.4, -90).size(75).anchor(0, 75).noStroke())
		.layout(new HGridLayout().startLoc(0, height/2).spacing(2, 0).cols(400))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HDrawable d = (HDrawable) obj;
					d.fill( colors.getColor(i*100), 3 );

					new HOscillator()
						.target(d)
						.property(H.X)
						.relativeVal(d.x())
						.range(-600, 300)
						.speed(0.3)
						.freq(0.5)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.relativeVal(d.y())
						.range(-300, 300)
						.speed(0.2)
						.freq(0.7)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(0, 360)
						.speed(0.7)
						.freq(2)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0.5, 4)
						.speed(0.3)
						.freq(5)
						.currentStep(i)
					;
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
