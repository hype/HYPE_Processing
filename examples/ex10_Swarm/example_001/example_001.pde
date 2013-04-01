HDrawablePool pool;
HSwarm swarm;

int index, timerStart, timer;
int timerFire = 250;
int timerBase = timerFire;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(true);
	smooth();

	index = 0;
	timerStart = millis();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	swarm = new HSwarm()
		.goal(width/2,height/2)
		.speed(4)
		.turnEase(0.025f)
		.twitch(0)
	;

	pool = new HDrawablePool(40);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
			.size(18,6)
		)
		.setOnCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d
						.fill( colors.getColor() )
						.loc( 500, 100 )
						.anchorAt( H.CENTER )
					;

					// Add "d" to swarm's list of targets
					swarm.addTarget(d);
				}
			}
		)
	;
}

void draw() {
	timer = millis() - timerStart;
	if (timer >= timerFire) {
		if(!pool.isFull()){
			pool.request();
			index = pool.currentIndex() + 1;			
		}
	}
	timerFire = timerBase * index;

	H.drawStage();

	// draw an ellipse to show swarm point
	noFill(); strokeWeight(2); stroke(#0095a8);
	ellipse(width/2, height/2, 4, 4);

	// draw an ellipse to show creation point
	noFill(); strokeWeight(2); stroke(#FF3300);
	ellipse(500, 100, 4, 4);
}