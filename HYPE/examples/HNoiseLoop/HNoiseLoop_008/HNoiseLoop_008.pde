import hype.*;
import hype.extended.behavior.HNoiseLoop;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

HDrawablePool pool, pool2;

void setup() {
	size(640,640);
	// frameRate(24);
	H.init(this).background(#242424);

	pool = new HDrawablePool(90);
	pool.autoAddToStage()
		.add(new HRect(6).rounding(2).anchorAt(H.CENTER).noStroke())
		.colorist(new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600).fillOnly())
		.layout(new HGridLayout().startLoc(9, height/2).spacing(7, 0).cols(90))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					
					HDrawable d = (HDrawable) obj;

					new HNoiseLoop()
						.target(d)
						.property(H.Y)
						.relativeVal(320)
						.range(-200, 200)
						.radius(150)
						.currentStep(i)
						.clockwise(true)//sample noise in clockwise direction
					;
				}
			}
		)
		.requestAll()
	;

	pool2 = new HDrawablePool(90);
	pool2.autoAddToStage()
		.add(new HRect(6).rounding(2).anchorAt(H.CENTER).noStroke())
		.colorist(new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600).fillOnly())
		.layout(new HGridLayout().startLoc(9, height/2).spacing(7, 0).cols(90))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool2.currentIndex();
					
					HDrawable d = (HDrawable) obj;

					new HNoiseLoop()
						.target(d)
						.property(H.Y)
						.relativeVal(320)
						.range(-200, 200)
						.radius(150)
						.currentStep(i)
						.clockwise(false)//sample noise in anti-clockwise direction
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
