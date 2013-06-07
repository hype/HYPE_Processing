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

					HRotate r = new HRotate();
					r.target(d).speed( random(-4,4) );
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	H.drawStage();
}

