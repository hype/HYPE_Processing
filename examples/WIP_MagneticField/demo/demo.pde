HDrawablePool pool;
HMagneticFieldLayout mfl ;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	mfl = new HMagneticFieldLayout(20, width, height, "");
	mfl.addPositivePole(new PVector(500,500) );	
	mfl.addNegativePole(new PVector(150, 200) );

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
				}
			}
		)
		.requestAll();
}

void draw() {
	HIterator<HDrawable> it = pool.iterator();
	while(it.hasNext()) {
		HDrawable d = it.next();
		 d.rotation( degrees( mfl.getAngle(d.loc()) ) );
	}

	mfl.setPositivePole(0, new PVector(mouseX, mouseY));

	H.drawStage();
}