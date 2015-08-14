import hype.*;

HDrawablePool pool;
HOscillator amplifier_wave, reducer_wave;
HColorField colors;

void setup() {
	size(640, 640);
	H.init(this).background(#242424);

	colors = new HColorField(width, height)
		.addPoint(0, height/2, #FF0033, 1.0f)
		.addPoint(width, height/2, #ff8822, 0.60f)
		.strokeOnly()
		.appliesAlpha(false)
	;

	amplifier_wave = new HOscillator()
						.property(H.Y)
						.range(-50, -150)
						.speed(1)
						.freq(5)
						.waveform(H.SQUARE)
					;
	reducer_wave = new HOscillator()
						.range(-100, 100)
						.speed(1.65)
						.freq(2.5)
						.waveform(H.TRIANGLE)
					;

	pool = new HDrawablePool(90);
	pool.autoAddToStage()
		.add (
			new HEllipse(25)
			.anchorAt(H.CENTER)
			.noFill()
			.strokeWeight(2)
			.stroke(0)
		)

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

					colors.applyColor( d );

					new HOscillator()
						.target(d)
						.property(H.X)
						.relativeVal(d.x())
						.range(-200, 200)
						.speed(1)
						.freq(1)
						.currentStep( pool.currentIndex() )
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.relativeVal(d.y())
						.range(-200, 200)
						.speed(1.5)
						.freq(1)
						.addReducer(reducer_wave)
						.currentStep( pool.currentIndex()*0.7 )
					;

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.relativeVal(25)
						.range(-100, 100)
						.speed(0.5)
						.freq(2)
						.addAmplifier(amplifier_wave)
						.clipping(-180, 20)
						.offset(-80)
						.currentStep( pool.currentIndex() )
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
