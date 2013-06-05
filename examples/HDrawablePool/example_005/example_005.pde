HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
		)

		.add (
			new HEllipse(), 25
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.fill(#242424)
						.strokeWeight(1)
						.stroke(#999999)
						.loc( (int)random(width), (int)random(height) )
						.anchor( new PVector(25,25) )
						.rotation( (int)random(360) )
						.size( 25 + ( (int)random(3)*25 ) )
					;

					d.extras(
						new HBundle().num( "letsRotate",random(-4,4) )
					);
				}
			}
		)

		.requestAll()
	;
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

