HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
		)
	    .setOnCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d
						.fill(#242424)
						.strokeWeight(1)
						.stroke(#999999)
						.loc( (int)random(width), (int)random(height) )
						.anchor( new PVector(10,10) )
						.rotation( (int)random(360) )
						.size(50,50)
					;
					
					d.extras(
						new HBundle().num( "letsRotate",random(-2,2) )
					);
				}
			}
		)
		.requestAll();
}

// when testing in browsers - it does NOT work in Safari
// works fine in Chrome and Firefox
// any ideas ?

void draw() {
	HIterator<HDrawable> it = pool.iterator();
	while(it.hasNext()) {
		HDrawable d = it.next();
		HBundle extras = d.extras();
		d.rotate(extras.num("letsRotate"));
	}

	H.drawStage();
}