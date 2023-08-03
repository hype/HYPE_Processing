import hype.*;
import hype.extended.behavior.HOrbiter3D;
import hype.extended.colorist.HColorPool;

HDrawablePool pool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( new HSphere() ).size(200).strokeWeight(0).noStroke().fill(#666666).anchorAt(H.CENTER).loc(width/2, height/2);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HSphere())
		.colorist( new HColorPool(#333333,#494949,#5F5F5F,#707070,#7D7D7D,#888888,#949494,#A2A2A2,#B1B1B1,#C3C3C3,#D6D6D6,#EBEBEB,#FFFFFF).fillOnly() )
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HSphere d = (HSphere) obj;
					int ranSize = 10 + ( (int)random(3)*7 );

					d.size(ranSize).strokeWeight(0).noStroke().anchorAt(H.CENTER);

					HOrbiter3D orb = new HOrbiter3D(width/2, height/2, 0)
						.target(d)
						.zSpeed(random(-1.5, 1.5))
						.ySpeed(random(-0.5, 0.5))
						.radius(195)
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
	pointLight(100, 0, 0,  width/2, height, 200);              // under red light
	pointLight(51, 153, 153,  width/2, -50, 150);              // over teal light
	pointLight(204, 204, 204,  width/2, (height/2) - 50, 500); // mid light gray light

	sphereDetail(20);
	H.drawStage();
}
