// Based on a visual idea by Victor Mattos

import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
HColorPool    colors;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #333333, #0095a8, #FF3300, #FF6600);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HRect(91).noStroke().anchorAt(H.CENTER).rotation(45))
		.layout(new HGridLayout().startX(32).startY(32).spacing(64,64).cols(10))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.fill( colors.getColor() );
				}
			}
		)
		.shuffleRequestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {

}
