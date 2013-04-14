HDrawablePool pool;
HMagneticField mf;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	mf = new HMagneticField()
		.pole(150, 200, true) // isSouth
		.pole(490, 440, false) // isNorth
	;

	pool = new HDrawablePool(930);
	pool.autoAddToStage()
		.add(
			new HRect()
			.rounding(2)
			.size(5,15)
			.anchorAt(H.CENTER)
		)
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
					d.fill( colors.getColor() );
					
					// mf.addTarget(d);
				}
			}
		)
		.requestAll();
}

void draw() {
	H.drawStage();
}