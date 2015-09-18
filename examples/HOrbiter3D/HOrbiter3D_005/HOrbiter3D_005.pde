import hype.*;
import hype.extended.behavior.HOrbiter3D;
import hype.extended.colorist.HColorPool;

HDrawablePool pool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool(42);
	pool.autoAddToStage()
		.add(new HRect(50).rounding(10))
		.colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly() )
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().anchorAt(H.CENTER).rotation(45);

					HOrbiter3D orb = new HOrbiter3D(width/2, height/2, 0)
						.target(d)
						.zSpeed(random(-1.5, 1.5))
						.ySpeed(random(-0.5, 0.5))
						.radius(250)
						.zAngle( (int)random(360) )
						.yAngle( (int)random(360) )
					;
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();

	//simple sphere mesh to show orbit range
	pushMatrix();
		translate(width/2, height/2, 0);
		stroke(#4D4D4D);
		noFill();
		sphereDetail(20);
		sphere(200);
	popMatrix();
}
