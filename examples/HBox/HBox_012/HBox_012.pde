import hype.*;
import hype.extended.behavior.HOscillator;

HDrawablePool pool;
HImage i1;

int boxSize = 200;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);
	lights();

	i1 = new HImage("texture.png");

	HBox b = new HBox();
	b.noStroke();
	b.texture(i1);

	pool = new HDrawablePool(25);
	pool.autoAddToStage()
		.add(b)
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HBox d = (HBox) obj;
					d.x(width/2).y(height/2).z(-500);

					d.fill(
						(int) map(i, 0, 19, 220, 0),
						(int) map(i, 0, 19, 0, 150),
						(int) map(i, 0, 19, 100, 160),
						40
					);

					d.depth(boxSize * (0.5 + (2.0/50.0 * i * 5)));
					d.width(boxSize * (0.5 + (2.0/50.0 * i * 5)));
					d.height(boxSize * (0.5 + (2.0/50.0 * i * 5)));

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(-90, 90)
						.speed(0.2)
						.freq(3)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-90, 180)
						.speed(0.8)
						.freq(1)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(-360, 360)
						.speed(0.2)
						.freq(1)
						.currentStep(i)
					;
				}
			}
		)
		.requestAll()
	;

	blendMode(ADD);

}

void draw() {
	H.drawStage();
}

