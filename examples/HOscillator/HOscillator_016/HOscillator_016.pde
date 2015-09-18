import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
HOscillator   reducer_wave;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	reducer_wave = new HOscillator().range(-90, 90).speed(1).freq(2);

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

					new HOscillator()
						.target(d)
						.property(H.Y)
						.relativeVal(320)
						.range(-100, 100)
						.speed(1)
						.freq(2)
						.addReducer(reducer_wave)
						.currentStep(i*3)
					;
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();

	textSize(24);
	text("Hold spacebar to disable wave reducer", 95, height - 24); 
}

void keyPressed() {
	if (key == ' ') reducer_wave.range(0, 0);
}

void keyReleased(){
	reducer_wave.range(-90, 90);
}
