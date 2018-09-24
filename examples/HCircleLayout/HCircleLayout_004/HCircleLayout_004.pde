import hype.*;
import hype.extended.layout.HCircleLayout;

HDrawablePool pool;
float         numAssets = 200.0;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool((int)numAssets);
	pool.autoAddToStage()
		.add(new HRect(2,100).rounding(4))

		.layout(
			new HCircleLayout()
			.radius(200)
			.startLoc(width/2,height/2)
			.angleStep(360.0/numAssets)
			.rotateTarget(true)

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
