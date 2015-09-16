import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HRotate;

HDrawablePool pool;
HColorPool    colors;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool()
		.add(#FFFFFF, 9)
		.add(#ECECEC, 9)
		.add(#CCCCCC, 9)
		.add(#333333, 3)
		.add(#0095a8, 2)
		.add(#00616f, 2)
		.add(#FF3300)
		.add(#FF6600)
	;

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HRect().rounding(10))
		.add(new HEllipse(), 25)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill( colors.getColor() )
						.loc( (int)random(width), (int)random(height) )
						.anchor( new PVector(25,25) )
						.rotation( (int)random(360) )
						.size( 25+((int)random(3)*25) )
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
