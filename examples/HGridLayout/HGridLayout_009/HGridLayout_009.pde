import hype.*;

HDrawablePool pool;
HOscillator h;

int tick = 0;
float scale = 0;
float r = 0;

void setup() {
	size(640,640, P3D);
	background(0);
	fill(0);
	rect(0, 0, width, height);
	H.init(this).background(#202020).use3D(true);
	lights();

	h = new HOscillator()
		.range(0.2, 2.5)
		.speed(1)
		.freq(5)
	;

	pool = new HDrawablePool(125);
	pool.autoAddToStage()
		.add (
			new HBox()
				.depth(25)
				.width(25)
				.height(25)
				.stroke(255, 50)
				.noFill()
		)

		.layout (
			new HGridLayout()
			.startX(180)
			.startY(180)
			.startZ(-140)
			.spacing(70, 70, 70)
			.cols(5)
			.rows(5)
		)

		.requestAll()
	;
}

void draw() {

	translate(width/2, height/2);
	rotateY(radians(r));
	translate(-width/2, -height/2);

	int i = 0;

	for (HDrawable d : pool) {

		h.currentStep(tick/2 + i * 3.145);

		HBox b = (HBox) d;

		float raw = h.nextRaw();
		scale = h.curr();

		b.width(60 * scale);
		b.height(60 * scale);
		b.depth(60 * scale);

		b.rotate(3);
		b.rotation(i);
		b.rotateY(3);

		i++;
	}

	H.drawStage();

	tick++;

	r+= 0.3;

}