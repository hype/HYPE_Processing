import hype.*;

HDrawablePool pool;
HOscillator amplifier_wave;

void setup() {
	size(640, 640);
	H.init(this).background(#202020);

	amplifier_wave = new HOscillator()
						.property(H.Y)
						.range(-50, -150)
						.speed(1)
						.freq(5)
						.waveform(H.SQUARE)
					;

	pool = new HDrawablePool(90);
	pool.autoAddToStage()
		.add(
			new HRect(6)
				.rounding(2)
				.anchorAt(H.CENTER)
				.noStroke()
		)

		.colorist( new HColorPool( #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600).fillOnly() )

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
						.property(H.HEIGHT)
						.relativeVal(320)
						.range(-100, 100)
						.speed(1)
						.freq(2)
						.addAmplifier(amplifier_wave)
						.clipping(-180, 20)
						.offset(-80)
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
	textSize(24);
	text("Hold spacebar to change wave amplifier speed", 45, height - 24); 
}

void keyPressed() {
	if (key == ' ') {
		amplifier_wave.speed(2);
	}
}

void keyReleased(){
	amplifier_wave.speed(1);
}