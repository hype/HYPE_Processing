import hype.*;
import hype.extended.behavior.HRotate;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HRect(10,50).rounding(4))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.strokeWeight(1)
						.stroke(#999999)
						.fill(#202020)
						.loc( (int)random(width), (int)random(height) )
						.anchor( 5, 100 )
						.rotation( (int)random(360) )
					;

					HRotate r = new HRotate();
					r.target(d).speed( random(-2,2) );
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
