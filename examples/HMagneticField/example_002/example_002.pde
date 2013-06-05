HDrawablePool pool;
HMagneticField field;
HColorPool colors;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly();

	PShape arrow = loadShape("arrow.svg");

	field = new HMagneticField().addMagnet(width/2,height/2, 320, 140);

	pool = new HDrawablePool(930);
	pool.autoAddToStage()
		.add (
			new HShape(arrow)
			.enableStyle(false)
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
	HMagneticField.HMagnet m = field.magnet(0);
	m.southx = mouseX;
	m.southy = mouseY;
	H.drawStage();
}

