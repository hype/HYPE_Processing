HDrawablePool pool;
HSwarm swarm;
HTimer timer;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	swarm = new HSwarm()
		.goal(width/2,height/2)
		.speed(5)
		.turnEase(0.05f)
		.twitch(20)
	;

	pool = new HDrawablePool(40);
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
						.size((int)random(10,20), (int)random(2,6) )
						.fill( colors.getColor() )
						.strokeWeight(2)
						.stroke(#000000, 100)
						.loc( width/2, height/2 )
						.anchorAt( H.CENTER )
					;

					// Add "d" to swarm's list of targets
					swarm.addTarget(d);
				}
			}
		)
	;

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(250)
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
	// use the mouse as the swarm point
	if(H.mouseStarted()) {
		swarm.goal(mouseX,mouseY);
	}

	H.drawStage();
}
