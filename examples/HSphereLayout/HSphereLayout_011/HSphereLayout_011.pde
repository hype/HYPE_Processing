import hype.*;
import hype.extended.layout.HSphereLayout;
import hype.extended.behavior.HOscillator;

HDrawablePool     pool;
HSphereLayout     layout;

void setup() {
	size(640, 640, P3D); 
	H.init(this).background(#151515).use3D(true);
	smooth();
	pixelDensity(2);

	pool = new HDrawablePool(100);

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(150)
		.rotate(true)
		.extendRadius(25)
		.ignorePoles()
		.offsetRows(true)
		;
	
	pool.add(new HIcosahedron())
		.layout(layout)
		.autoAddToStage()
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.depth(10);
					d.size(10, 10);
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
						.property(H.X)
						.waveform(H.EASE)
						.relativeVal(d.x())
						.range(-100, 100)
						.speed(2.0)
						.freq(1.5)
						.currentStep(i * 3)
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.waveform(H.EASE)
						.relativeVal(d.y())
						.range(-100, 100)
						.speed(1.0)
						.freq(1.5)
						.currentStep(i * 3)
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.waveform(H.EASE)
						.relativeVal(d.z())
						.range(-200, 100)
						.speed(0.15)
						.freq(10)
						.currentStep(i * 3)
					;

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.waveform(H.EASE)
						.range(1, 2.5)
						.speed(0.15)
						.freq(10)
						.currentStep(i * 3)
					;

				}
			}
		)
		.requestAll();

}

void draw() {

	if (mousePressed) {
		translate(width/2, height/2);
		rotateX(map(mouseY, 0, height, -(TWO_PI / 2), TWO_PI/2));
		rotateY(map(mouseX, 0, width, -(TWO_PI / 2), TWO_PI/2));
		translate(-width/2, -height/2);
	}

	lights();

	H.drawStage();
} 
