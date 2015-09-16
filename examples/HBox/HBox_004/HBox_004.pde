import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HSwarm;

HDrawablePool pool, swarmPool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HBox())
		.layout(new HGridLayout().startX(-125).startY(-125).spacing(100,100).cols(10))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int ranSize = 25 + ( (int)random(5)*25 );
					HBox d = (HBox) obj;
					d.depth(ranSize).width(ranSize).height(ranSize).noStroke().z( (int)random(-600, 0) ).rotationZ(random(360));
				}
			}
		)
		.requestAll()
	;

	swarmPool = new HDrawablePool(3);
	swarmPool.autoAddToStage()
		.add(new HEllipse(10))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.strokeWeight(2).stroke(#ECECEC).fill(#111111).loc( (int)random(width), (int)random(height) ).anchorAt(H.CENTER);

					new HSwarm()
						.addTarget(d)
						.speed(4)
						.turnEase(0.02)
						.twitch(20)
						.addGoal(width/2,height/2)
					;
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	int i = 0;

	for(HDrawable d : swarmPool) {
		switch (i) {
			case 0:
				d.stroke(255, 51, 0);
				pointLight(255, 51, 0,  d.x(), d.y(), -300 ); // orange
				break;
			case 1:
				d.stroke(0, 149, 168);
				pointLight(0, 149, 168, d.x(), d.y(), -300 ); // teal
				break;
			case 2:
				d.stroke(255, 204, 0);
				pointLight(255, 204, 0, d.x(), d.y(), -400 ); // yellow
				break;
		}
		++i;
	}

	H.drawStage();
}

