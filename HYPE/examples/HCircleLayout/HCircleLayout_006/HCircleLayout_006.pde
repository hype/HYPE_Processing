import hype.*;
import hype.extended.layout.HCircleLayout;

HDrawablePool pool;
float         numAssets = 50.0;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool((int)numAssets);
	pool.autoAddToStage()
		.add(new HRect(100,1))

		.layout(
			new HCircleLayout()
			.radius(200)
			.startLoc(width/2,height/2)
			.rotateTarget(true)
			.startAngle(-90.0)
			.angleStep(180.0/numAssets)
		)
		
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
				}
			}
		)
		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {

}
