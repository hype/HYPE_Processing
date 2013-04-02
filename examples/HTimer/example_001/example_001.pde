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

	// This example demonstrates how to use HTimer.

	// HTimer is yet another HBehavior class, so it has all the methods
	// common to all other behaviors; and it registers itself automatically
	// to the stage.

	// Unlike most other behaviors, HTimer takes an HCallback instead of th usual "target".

	// if numCycles <= 0, then HTimer will repeat indefinitely
	// .cycleIndefinitely() // same as numCycles( 0 )
	// .useFrames() // treats the interval as the number of frames between executing callbacks
	// .useMillis() // treats the interval as the number of milliseconds
	// HCallback.run() is called once HTimer times out.

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(50) // set the interval
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