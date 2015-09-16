import hype.*;
import hype.extended.behavior.HRotate;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HRect().rounding(4))
		.add(new HEllipse(), 25)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.strokeWeight(1)
						.stroke(#999999)
						.fill(#202020)
						.loc( (int)random(width), (int)random(height) )
						.anchor( 25, 25 )
						.rotation( (int)random(360) )
						.size( 25 + ((int)random(3)*25) )
					;

					HRotate r = new HRotate();
					r.target(d).speed( random(-4,4) );
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
