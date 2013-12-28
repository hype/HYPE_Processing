HDrawablePool pool;
HMagneticField field;
HColorPool colors;

int numMagnets = 10;

void setup() {
	size(640,640);

	H.init(this).background(#000000);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC).fillOnly();
	
	field = new HMagneticField();

	for (int i = 0; i<numMagnets; i++){
		if ( (int)random(2) == 0 ) field.addPole( (int)random(width), (int)random(height),   3); // x, y, north polarity / strength =  3 / repel
		else                       field.addPole( (int)random(width), (int)random(height),  -3); // x, y, south polarity / strength = -3 / attract
	}

	pool = new HDrawablePool(2500);
	pool.autoAddToStage()
		.add(
			new HShape("arrow.svg")
			.enableStyle(false)
			.anchorAt(H.CENTER)
		)

		.colorist(colors)

		.layout(
			new HGridLayout()
			.startX(-60)
			.startY(-60)
			.spacing(16,16)
			.cols(50)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().anchor(-20,-20);

					field.addTarget(d);
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {}

