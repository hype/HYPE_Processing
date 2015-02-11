HColorPool colors;

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#202020);
	smooth();

	HCanvas c = new HCanvas(P3D).autoClear(false).fade(2);
	H.add(c);

	colors = new HColorPool(#ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	HDrawablePool pool = new HDrawablePool(42);
	pool.autoParent(c)

		.add(
			new HShape("mon.svg").enableStyle(false)
				.scale(0.1)
				.strokeWeight(1/.1)
				.fill(#FF4400)
				.rotation(45)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					d.fill(colors.getColor());

					float r = floor(random(10, 40)) * 10;

					HOrbiter3D o = new HOrbiter3D(width/2, height/2, 0)
						.target(d)
						.zSpeed(random(-1.5, 1.5))
						.ySpeed(random(-0.5, 0.5))
						.radius(r)
					;
				}
			}
		)

		.requestAll()
	;

}

void draw() {
	H.drawStage();
}
