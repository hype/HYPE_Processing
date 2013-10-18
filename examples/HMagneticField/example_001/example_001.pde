HDrawablePool pool;
HMagneticField field;
HColorPool colors;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly();
	
	//add Magnet requires a north and south set of poles, nx, ny, sx, sy
	field = new HMagneticField().addMagnet(width/4,height/2, width*3/4, height*3/4);

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
	//getting second pole, which is the south pole of the magent we added above
	HMagneticField.HPole p = field.pole(1);
	p._x = mouseX;
	p._y = mouseY;
	H.drawStage();
}

