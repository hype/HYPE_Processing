import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.layout.HSphereLayout;

HDrawablePool pool;
HSphereLayout layout;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true);

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(100)
		.rotate(true)
		.extendRadius(35)
		.useSpiral()
		.phiModifier(3.0001)
	;

	pool = new HDrawablePool(500);
	pool.autoAddToStage()
		.add(new HBox())
		.layout(layout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.size(5).depth(35).noStroke();

					int i = pool.currentIndex() / 100;

					switch (i) {
						case 0: d.fill(#FF6600); break;
						case 1: d.fill(#0095a8); break;
						case 2: d.fill(#333333); break;
						case 3: d.fill(#FF3300); break;
						case 4: d.fill(#00616f); break;
					}

					new HOscillator().target(d).property(H.WIDTH).waveform(H.EASE).range(35.0, 0.1).speed(0.7).freq(5).currentStep(-i*5);
					new HOscillator().target(d).property(H.HEIGHT).waveform(H.EASE).range(35.0, 0.1).speed(0.7).freq(5).currentStep(-i*5);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	if (mousePressed) {
		translate(width/2, height/2);
		rotateX(map(mouseY, 0, height, -(TWO_PI/2), TWO_PI/2));
		rotateY(map(mouseX, 0, width,  -(TWO_PI/2), TWO_PI/2));
		translate(-width/2, -height/2);
	}

	lights();
	H.drawStage();
}
