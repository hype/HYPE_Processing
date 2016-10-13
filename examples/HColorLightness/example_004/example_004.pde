import hype.*;
import hype.extended.behavior.HColorLightness;
import hype.extended.behavior.HSwarm;
import hype.extended.colorist.HPixelColorist;

HSwarm         swarm;
HDrawablePool  pool;
HPixelColorist colors;
PImage         img;

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(false);

	// img = loadImage("gradient_ball.png");
	img = loadImage("orange_ball.png");
	// img = loadImage("skull.png");
	// img = loadImage("testplate.png");

	colors = new HPixelColorist(img).fillOnly();

	swarm = new HSwarm().addGoal(H.mouse()).speed(5).turnEase(0.2f).twitch(50);

	pool = new HDrawablePool(42);
	pool.autoAddToStage()
		.add (new HRect().rounding(10))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.stroke(0,127).size(30, 10).loc(width/2,height/2).anchorAt(H.CENTER);

					new HColorLightness(img)
						.property(H.SCALE)
						.useBrightness()
						.range(0.5, 1.5)
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
	for (HDrawable d : pool) {
		colors.applyColor(d);
	}

	H.drawStage();
}
