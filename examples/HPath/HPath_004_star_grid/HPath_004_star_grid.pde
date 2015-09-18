import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool(49);
	pool.autoAddToStage()
		.add(new HPath())
		.colorist(new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600).fillOnly())
		.layout(new HGridLayout().startX(81).startY(81).spacing(80,80).cols(7))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int ranEdges = round(random(5, 10));
					float ranDepth = random(0.25, 0.75);

					HPath path = (HPath) obj;
					path.star( ranEdges, ranDepth ).size(64).noStroke().anchorAt(H.CENTER).rotation( (int)random(360) );
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
