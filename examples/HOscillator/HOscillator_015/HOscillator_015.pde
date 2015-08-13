import hype.*;

HDrawablePool pool;
HOscillator amplifier_wave;

void setup() {
	size(640, 640);
	H.init(this).background(#202020);

	amplifier_wave = new HOscillator()
						.property(H.Y)
						.range(-100, 100)
						.speed(1)
						.freq(2)
					;

	pool = new HDrawablePool(90);
	pool.autoAddToStage()
		.add(
			new HRect(6)
				.rounding(2)
				.anchorAt(H.CENTER)
				.noStroke()
		)

		.colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600).fillOnly() )

		.layout(
			new HGridLayout()
				.startLoc(9, height/2)
				.spacing(7, 0)
				.cols(90)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.relativeVal(320)
						.range(-100, 100)
						.speed(1)
						.freq(2)
						.addAmplifier(amplifier_wave)
						.currentStep( pool.currentIndex()*3 )
					;
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	H.drawStage();
	fill(255);
	textSize(24);
	text("Hold spacebar to disable wave amplifier", 95, height - 24); 
}

void keyPressed() {
	if (key == ' ') {
		amplifier_wave.range(0, 0);
	}
}

void keyReleased(){
	amplifier_wave.range(-100, 100);
}