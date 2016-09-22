import hype.*;
import hype.extended.layout.HSphereLayout;
import hype.extended.behavior.HOscillator;

HDrawablePool     pool;
HSphereLayout     layout;
HOscillator       reducer_wave;

float r;

void setup() {
	size(640, 640, P3D); 
	H.init(this).background(#151515).use3D(true);
	smooth();
	// pixelDensity(2);

	pool = new HDrawablePool(200);

	reducer_wave = new HOscillator().range(-0.5, 2.5).speed(1.5).freq(2.2).waveform(H.TRIANGLE);

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(150)
		.rotate(true)
		.ignorePoles()
		.offsetRows(true)
		;
	
	pool.add(new HBox())
		.layout(layout)
		.autoAddToStage()
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.depth(50);
					d.size(5, 5);
					d.noStroke();

					int i = pool.currentIndex();

					switch ((i / 10) % 10) {
						case 0:
						case 5:
							d.fill(#FF6600);
							break;
						case 1:
						case 6:
							d.fill(#0095a8);
							break;
						case 2:
						case 7:
							d.fill(#eeeeee);
							break;
						case 3:
						case 8:
							d.fill(#FF3300);
							break;
						case 4:
						case 9:
							d.fill(#00616f);
							break;
					}

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(1.25, 3.5)
						.speed(0.75)
						.freq(1.6)
						.addReducer(reducer_wave)
						.currentStep(i*3)
					;

				}
			}
		)
		.requestAll();

		r = 0;
}

void draw() {

	translate(width/2, height/2);
	rotateY(r);
	translate(-width/2, -height/2);

	lights();

	H.drawStage();

	r += radians(.1);
} 
