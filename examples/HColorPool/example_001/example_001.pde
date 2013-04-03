HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(10)
		)
		.add (
			new HEllipse(), 25
		)
		.setOnCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d
						.fill( colors.getColor() )
						.loc( (int)random(width), (int)random(height) )
						.anchor( new PVector(25,25) )
						.rotation( (int)random(360) )
						.size( 25+((int)random(3)*25) )
					;
					
					d.extras(
						new HBundle().num( "letsRotate",random(-4,4) )
					);
				}
			}
		)
		.requestAll();
}

void draw() {
	HIterator<HDrawable> it = pool.iterator();
	while(it.hasNext()) {
		HDrawable d = it.next();
		HBundle extras = d.extras();
		d.rotate(extras.num("letsRotate"));
	}

	H.drawStage();
}