import hype.*;
import hype.extended.behavior.HParticles;

HDrawablePool pool;
HParticles    hp;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true);

	hp = new HParticles()
		.location(width/2, height/2)
		.minimumLife(10)
		.maximumLife(150)
		.speed(3.0)
		.decay(1.0)
		.fade(false)
	;

	pool = new HDrawablePool(400);
	pool.autoAddToStage()
		.add(new HSprite())
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(255).size(5).anchorAt(H.CENTER).rotation(45);
					hp.addParticle(d);
				}
			}
		)
		.requestAll()
	;
}


void draw() {
	H.drawStage();
}
