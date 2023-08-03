import java.util.Iterator;

import hype.*;
import hype.extended.behavior.HSwarm;
import hype.extended.behavior.HTimer;
import hype.extended.behavior.HTween;
import hype.extended.colorist.HColorPool;
import hype.interfaces.HLocatable;

HColorPool    colors;
HCanvas       canvas;
HSwarm        swarm;
HDrawablePool pool;
HTimer        timer;
int           i=0;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	H.add(canvas = new HCanvas()).autoClear(false).fade(40);

	swarm = new HSwarm()
		.speed(4)
		.turnEase(0.1f)
		.twitch(15)
		.idleGoal(width/2,height/2)
	;

	pool = new HDrawablePool(10);
	pool.autoAddToStage()
		.add(new HRect(10).rounding(5))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					final HDrawable d = (HDrawable) obj;
					d
						.strokeWeight(2)
						.stroke(#ECECEC)
						.fill(#111111)
						.loc((int)random(100,540), (int)random(100,540))
						.anchorAt(H.CENTER)
						.rotation(45)
					;

					final HTween tween = new HTween()
						.target(d).property(H.LOCATION)
						.start(d.x(), d.y())
						.end((int)random(width), (int)random(height))
						.ease(0.01).spring(0.9)
					;

					final HCallback onAnim = new HCallback() {
						public void run(Object obj) {
							tween
								.start(d.x(), d.y())
								.end((int)random(100,540), (int)random(100,540))
								.ease(0.01)
								.spring(0.9)
								.register()
							;
						}
					};

					timer = new HTimer().interval(2000).callback(onAnim);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	if(i++<100) { 
		swarm.addTarget(
			canvas.add(
				new HRect(8,2)
				.rounding(4)
				.anchorAt( H.CENTER )
				.noStroke()
				.fill(colors.getColor())
			)
		);
	}

	H.drawStage();

	for(Iterator<HLocatable> it=swarm.goals().iterator();it.hasNext();) {
		it.remove();
		it.next();
	}

	for(HDrawable d : pool) {
		swarm.addGoal(d.x(),d.y());
	}
}
