import hype.*;
import hype.extended.layout.HCircleLayout;

HDrawablePool pool;
float         numAssets = 100.0;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool((int)numAssets);
	pool.autoAddToStage()
		.add(new HRect(10))

		.layout(
			new HCircleLayout()
			.radius(225)
			.startX(width/2)
			.startY(height/2)
			.startZ(-250)
			.angleStep(360.0/numAssets)
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
