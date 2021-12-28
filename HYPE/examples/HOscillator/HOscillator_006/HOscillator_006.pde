import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
HColorPool    colors;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	pool = new HDrawablePool(320);
	pool.autoAddToStage()
		.add(new HRect(4).rounding(3).anchorAt(H.CENTER).noStroke())
		.layout(new HGridLayout().startLoc(0, height/2).spacing(2, 0).cols(320))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HDrawable d = (HDrawable) obj;
					d.fill( colors.getColor(i*100) );

					new HOscillator()
						.target(d)
						.property(H.Y)
						.relativeVal(d.y())
						.range(-200, 200)
						.speed(2)
						.freq(0.5)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(-180, 180)
						.speed(1)
						.freq(0.5)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.HEIGHT)
						.range(4, 200)
						.speed(2)
						.freq(1)
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
