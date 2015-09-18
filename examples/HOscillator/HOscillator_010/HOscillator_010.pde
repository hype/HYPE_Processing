import hype.*;
import hype.extended.behavior.HOscillator;

HCanvas canvas;
color[] palette = { #333333, #666666, #999999, #CCCCCC, #F7F7F7 };

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	canvas = H.add(new HCanvas()).autoClear(true);

	int starScale  = 200;
	int starOffest = 40;

	for (int i = 0; i<9; ++i) {
		for (int j = 0; j<5; ++j) {

			int row = floor(i/3.0);
			int col = i % 3;

			int   ranEdges = HMath.randomInt(5, 10);
			float ranDepth = random(0.25, 0.75);

			HPath d = (HPath) canvas.add( new HPath().star(ranEdges, ranDepth) )
				.size(starScale)
				.noStroke()
				.fill( palette[j] )
				.anchorAt(H.CENTER)
				.loc(col*200+120, row*200+120);
			;

			new HOscillator()
				.target(d)
				.property(H.ROTATION)
				.range(-20, 20)
				.speed(0.2)
				.freq(8)
				.currentStep(j)
			;

			starScale -= starOffest;
		}
		starScale = 200;
	}
}

void draw() {
	H.drawStage();
}

