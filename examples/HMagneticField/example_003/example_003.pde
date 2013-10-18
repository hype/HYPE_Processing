HDrawablePool pool;
HMagneticField field;
HColorPool colors;

void setup() {
	size(640,640);

	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly();
	
	//the Magnetic field supports multiple poles
	field = new HMagneticField()
	.addPole(width/4,height/3, 1)
	.addPole(width/4*3,height/3, 1)
	.addPole(width/2,height/4*3, -1)
	;

	pool = new HDrawablePool(930);
	pool.autoAddToStage()
		.add(
			new HRect()
			.rounding(2)
			.size(5,15)
			.anchorAt(H.CENTER)
		)

		.colorist(colors)

		.layout(
			new HGridLayout()
			.startX(5)
			.startY(15)
			.spacing(21,21)
			.cols(31)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke();
					field.addTarget(d);
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	H.drawStage();
}

