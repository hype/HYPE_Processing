HDrawablePool pool;
float rotation = 0;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#202020).autoClear(true).use3D(true);
	smooth();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add (
			new HBox()
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
					int i = pool.currentIndex();
					int ranSize = 25 + ( (int)random(3)*50 );
					HBox d = (HBox) obj;
					d
						.depth(ranSize) // depth is a 3D specific method, so put this first
						.width(ranSize)
						.height(ranSize)
						.noStroke()
						.z( (int)random(-400, 0) )
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.relativeVal(d.z())
						.range(-300, 300)
						.speed(1)
						.freq(3)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(-180, 180)
						.speed(0.1)
						.freq(5)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-360, 360)
						.speed(0.1)
						.freq(5)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(-90, 90)
						.speed(0.1)
						.freq(5)
						.currentStep(i)
					;
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	pointLight(255, 51, 0,  0, height/2, -300);        // orange
	pointLight(0, 149, 168,  width, height/2, -300);   // teal
	pointLight(255, 204, 0,  width/2, height/2, -400); // yellow

	float orbitRadius= 1000;
	float xpos= cos(radians(rotation))*orbitRadius;
	float zpos= sin(radians(rotation))*orbitRadius;
	
	camera(
		xpos, 0, zpos,
		width/2, height/2, 0,
		0, -1, 0
	);

	rotation++;

	H.drawStage();
}

