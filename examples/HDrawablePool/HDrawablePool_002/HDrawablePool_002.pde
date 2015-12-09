import hype.*;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HRect(50).rounding(5))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.strokeWeight(1)
						.stroke(#999999)
						.fill(#202020)
						.loc( (int)random(width), (int)random(height) )
						.anchorAt(H.CENTER)
						.rotation( 45 )
					;
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
