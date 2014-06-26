HSwarm swarm;
HDrawablePool pool;
HTimer timer;
PImage img;


void setup() {
	size(500,500);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	img = loadImage("skull.png");

	swarm = new HSwarm()
		.addGoal(H.mouse())
		.speed(3)
		.turnEase(0.35f)
		.twitch(80)
	;

	pool = new HDrawablePool(10);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
			.stroke(0)
			.strokeWeight(2)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.size((int)random(10,20), (int)random(2,6) )
						.loc(0,0)
						.anchorAt( H.CENTER )
					;

					new HColorLightness(img)
						.property(H.SCALE)
						.range(0, 1.5)
						.target(d)
					;

					new HColorLightness(img)
						.property(H.ALPHA)
						.range(10, 100)
						.target(d)
					;

					swarm.addTarget(d);
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