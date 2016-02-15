import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;

HColorPool colors;
HCanvas    canvas;

void setup() {
	size(640,640);
	H.init(this).background(#111111);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #ff3300, #ff3300, #242424, #333333, #666666);

	canvas = H.add(new HCanvas()).autoClear(true);

	int starScale  = 800;
	int starOffest = 15;

	for (int i=0; i<53; ++i) {
		HPath d = (HPath) canvas.add( new HPath().star(5, 0.5, -90) )
			.size(starScale)
			.noStroke()
			.fill( colors.getColor(i*250) )
			.anchorAt(H.CENTER)
			.locAt(H.CENTER)
		;

		new HOscillator()
			.target(d)
			.property(H.ROTATION)
			.range(-20, 20)
			.speed(0.4)
			.freq(8)
			.currentStep(i)
		;

		starScale -= starOffest;
	}
}

void draw() {
	H.drawStage();
}
