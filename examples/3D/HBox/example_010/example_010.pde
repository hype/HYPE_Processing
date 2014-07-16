HDrawablePool pool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();
	lights();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add (
			new HBox()
			.depth(64) // depth is a 3D specific method, so put this first
			.width(64)
			.height(64)

		)

		.layout (
			new HGridLayout()
			.startX(-125)
			.startY(-125)
			.spacing(100,100)
			.cols(10)
		)

		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					HBox d = (HBox) obj;
					d.z(-500);

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0.5, 1.5)
						.speed(1)
						.freq(2)
						.currentStep( pool.currentIndex()*3 )
					;
				}
			}
		)

		.requestAll()
	;

	
}

void draw() {

	translate(width/2, height/2, -500);
	rotateX(map(mouseY, 0, height, -(TWO_PI / 2), TWO_PI/2));
	rotateY(map(mouseX, 0, width, -(TWO_PI / 2), TWO_PI/2));
	translate(-width/2, -height/2, 500);

	H.drawStage();
}
