import hype.*;
import hype.extended.behavior.HOscillator;

HImage        t1;
int           cSize = 250;
HDrawablePool pool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	t1 = new HImage("tex5.png");

	pool = new HDrawablePool(25);
	pool.autoAddToStage()
		.add( new HCylinder().texture(t1) )
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HCylinder d = (HCylinder) obj;
					d
						.depth(cSize)
						.width(cSize)
						.height(cSize)
						.strokeWeight(1)
						.stroke(#CCCCCC, 225)
						.fill(#FF3300, 225)
						.loc(width/2, height/2)
					;

					new HOscillator().target(d).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(1).currentStep(i*1.25).waveform(H.SINE);
					new HOscillator().target(d).property(H.ROTATIONY).range(-360, 360).speed(0.2).freq(1).currentStep(i*1.25).waveform(H.SINE);
					new HOscillator().target(d).property(H.ROTATIONZ).range(-360, 360).speed(0.3).freq(1).currentStep(i*1.25).waveform(H.SINE);

				}
			}
		)
		.requestAll()
	;
}

void draw() {
	lights();
	H.drawStage();
}
