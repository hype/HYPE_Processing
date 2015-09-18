import hype.*;
import hype.extended.behavior.HOrbiter3D;
import hype.extended.behavior.HTimer;

HDrawablePool pool;
HTimer        timerPool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool(42);
	pool.autoAddToStage()
		.add(new HRect(50).rounding(10))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.stroke(#000000, 50).fill(#FF3300).anchorAt(H.CENTER).rotation(45).loc(width/2,height/2);

					HOrbiter3D orb = new HOrbiter3D(width/2, height/2, 0)
						.target(d)
						.zSpeed(1.5)
						.ySpeed(0.2)
						.radius(250)
					;
				}
			}
		)
	;

	timerPool = new HTimer()
		.numCycles( pool.numActive() )
		.interval(75)
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

	//simple sphere mesh to show orbit range
	pushMatrix();
		translate(width/2, height/2, 0);
		stroke(#666666);
		noFill();
		sphereDetail(20);
		sphere(200);
	popMatrix();
}
