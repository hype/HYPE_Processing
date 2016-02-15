import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HOscillator;

HDrawablePool pool;
HOscillator   osc;
float         scale = 0;
float         r     = 0;

void setup() {
	size(640,640, P3D);
	H.init(this).background(#242424).use3D(true);

	osc = new HOscillator().range(0.2, 2.5).speed(10).freq(2);

	pool = new HDrawablePool(125);
	pool.autoAddToStage()
		.add(new HBox().depth(25).width(25).height(25))
		.layout (new HGridLayout().startX(180).startY(180).startZ(-140).spacing(70, 70, 70).cols(5).rows(5))
		.requestAll()
	;
}

void draw() {
	lights();

	translate( width/2,  height/2);
	rotateY( radians(r) );
	translate(-width/2, -height/2);
	r+=0.3;

	int i = 0;

	for (HDrawable d : pool) {
		osc.currentStep(frameCount + i * 3).nextRaw();
		scale = osc.curr();

		HBox b = (HBox) d;
		b.depth(25 * scale).width(25 * scale).height(25 * scale);

		i++;
	}

	H.drawStage();
}
