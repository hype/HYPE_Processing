HDrawablePool pool;
HTimer timer;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(10)
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
						.rotation(45)
						.size( 50+((int)random(3)*50) )
						.anchorAt( H.CENTER )
					;
				}
			}
		)
	;

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(50)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					pool.request();
				}
			}
		)
	;
}

void draw() {
	H.drawStage();
}