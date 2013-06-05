HDrawablePool pool;
HColorPool colors;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool()
		.add(#FFFFFF, 9)
		.add(#ECECEC, 9)
		.add(#CCCCCC, 9)
		.add(#333333, 3)
		.add(#0095a8, 2)
		.add(#00616f, 2)
		.add(#FF3300)
		.add(#FF6600)
	;

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(10)
		)

		.add (
			new HEllipse(), 25
		)

		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.fill( colors.getColor(), 50 )
						.strokeWeight(4)
						.stroke( colors.getColor(), 150 )
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

