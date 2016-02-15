import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;
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

	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add(new HRect(50).rounding(4))
		.layout(new HGridLayout().startX(32).startY(32).spacing(25,25).cols(24))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill( colors.getColor() ).alpha( (int)random(50,200) ).anchorAt(H.CENTER);

					HRotate rot = new HRotate();
					rot.target(d).speed( random(-2,2) );
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}

