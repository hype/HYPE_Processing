HSwarm swarm;
HDrawablePool pool;
HTimer timer;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(true);
	smooth();

	swarm = new HSwarm()
		.addGoal(width/2,height-200)
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

		.colorist(new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly())

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					float rotation = random(TWO_PI);
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.loc( width/2, 200 )
						.rotationRad(rotation)
						.move(cos(rotation)*10, sin(rotation)*10)
						.anchorAt( H.CENTER )
					;

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
	H.drawStage();

	// draw an ellipse to show swarm point
	noFill(); strokeWeight(2); stroke(#0095a8);
	ellipse(width/2, height-200, 4, 4);

	// draw an ellipse to show creation point
	noFill(); strokeWeight(2); stroke(#FF3300);
	ellipse(width/2, 200, 4, 4);
}

