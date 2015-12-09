import hype.*;
import hype.extended.layout.HPolarLayout;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;

HDrawablePool pool;
HColorPool    colors;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	HPolarLayout layout = new HPolarLayout(0.5, 0.1).offset(width/2, height/2);

	pool = new HDrawablePool(600);
	pool.autoAddToStage()
		.add(new HPath().polygon(6).size(50,50).strokeWeight(1).fill(#181818).anchor(25,-100))
		.layout(layout)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HPath d = (HPath) obj;
					d.stroke( colors.getColor(i*100) );

					new HOscillator().target(d).property(H.SCALE).range(0.25, 1.25).speed(0.7).freq(5).currentStep(i);
					new HOscillator().target(d).property(H.ROTATION).range(-360, 360).speed(0.05).freq(3).currentStep(i);
					new HOscillator().target(d).property(H.Z).range(-900, 100).speed(1).freq(1).currentStep(i);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
