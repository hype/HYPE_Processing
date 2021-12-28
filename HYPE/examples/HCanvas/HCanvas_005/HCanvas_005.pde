import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HTimer;
import hype.extended.behavior.HSwarm;

HColorPool    colors;
HCanvas       canvas;
HDrawablePool pool;
HSwarm        swarm;
HTimer        timer;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	canvas = (HCanvas) H.add(new HCanvas().autoClear(false).fade(2));

	swarm = new HSwarm().addGoal(H.mouse()).speed(5).turnEase(0.05f).twitch(20);

	pool = new HDrawablePool(40);
	pool.autoParent(canvas)
		.add(new HRect().rounding(4))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.strokeWeight(2).stroke(#000000, 100).fill(colors.getColor()).size((int)random(10,20),(int)random(2,6)).loc(width/2,height/2).anchorAt(H.CENTER);
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
}
