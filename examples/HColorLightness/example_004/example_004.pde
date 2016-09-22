import hype.*;
import hype.extended.behavior.HSwarm;
import hype.extended.behavior.HColorLightness;
import hype.extended.behavior.HTimer;

HSwarm swarm;
HDrawablePool pool;
PImage img;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	img = loadImage("gradient_ball.png");

	swarm = new HSwarm()
		.addGoal(H.mouse())
		.speed(2.5)
		.turnEase(0.35f)
		.twitch(80)
	;

	pool = new HDrawablePool(42);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(10)
			.stroke(#202020)
			.strokeWeight(1.5)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.size(30, 10)
						.loc(0,0)
						.anchorAt( H.CENTER )
					;

					//random pink color
					int r = (int)random(190, 255);
					d.fill(r, 160, 160);

					new HColorLightness(img)
						.property(H.SCALE)
						.range(0, 1.5)
						.target(d)
					;

					new HColorLightness(img)
						.property(H.ALPHA)
						.range(0, 100)
						.target(d)
					;

					swarm.addTarget(d);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
