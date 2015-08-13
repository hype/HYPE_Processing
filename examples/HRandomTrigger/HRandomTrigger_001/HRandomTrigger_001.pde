HRandomTrigger rand;
HDrawable d;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	/*
	* Create a new randomTrigger with a 1 in 15 chance
	* of triggering everytime H.drawStage() is called.
	*/

	rand = new HRandomTrigger( 1f/15 );
	// rand = new HRandomTrigger().chance( 1f/15 ); // same as above

	d = H.add( new HRect().rounding(8) )
		.fill(#242424)
		.strokeWeight(1)
		.stroke(#999999)
		.locAt(H.CENTER)
		.size( 50+((int)random(3)*50) )
		.anchorAt( H.CENTER )
	;

	// Setting the callback is similar to HTimer

	rand.callback(
		new HCallback(){
			public void run(Object obj) {
				d
					.loc( random(50,width-50), random(50,height-50) )
					.size( 50+((int)random(3)*50) )
					.anchorAt( H.CENTER )
					.rotationRad( random(TWO_PI) )
				;
			}
		}
	);
}

void draw() {
	H.drawStage();
}

