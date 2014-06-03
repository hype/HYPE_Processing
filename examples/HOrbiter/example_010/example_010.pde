/*
	Press spacebar while running the sketch to randomize the pool and orbit
*/
HDrawablePool pool;
HColorPool colors;
HCanvas canvas;

void setup() {
	size(640, 640);
	H.init(this).background(#202020);
	smooth();

	canvas = new HCanvas().autoClear(false).fade(10);
	H.add(canvas);

	colors = new HColorPool(#FFFFFF, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	pool = new HDrawablePool(42);
	pool.autoParent(canvas)

		.add(
			new HRect(100, 2)
				.rounding(10)
				.anchorAt(H.CENTER)
				.noStroke()
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					d.fill(colors.getColor());

					float r = floor(random(10, 31)) * 10;

					HOrbiter orbit = new HOrbiter(width/2, height/2)
						.speed(random(.5, 1.5))
						.radius(r)
						.startAngle(random(360))
					;

					new HOrbiter()
						.target(d)
						.speed(-10)
						.radius(random(25, 50))
						.rotateTarget(true)
						.startAngle(random(360))
						.parent(orbit)
					;

					d.extras( new HBundle().obj("orbit", orbit) );
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	H.drawStage();
}

void keyPressed(){
	if (key == ' ') {
		randomize();
	}
}

void randomize() {
	for(HDrawable d : pool) {
		d.fill(colors.getColor());

		float r = floor(random(10, 31)) * 10;

		HBundle bundle = d.extras();
		HOrbiter orbit = (HOrbiter) bundle.obj("orbit");

		orbit.radius(r);
	}
}