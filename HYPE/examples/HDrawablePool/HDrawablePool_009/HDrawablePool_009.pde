// click the mouse to drain the pool and repopulate

import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
HGridLayout   layout;
HColorPool    colors;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	layout = new HGridLayout().startX(32).startY(32).spacing(64,64).cols(10);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HRect(70).rounding(5).anchorAt(H.CENTER).rotation(45))
		.add(new HEllipse(80).anchorAt(H.CENTER))
		.layout(layout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(colors.getColor());
				}
			}
		)
		.shuffleRequestAll()
	;
}

void draw() {
	H.drawStage();
}

void mouseReleased() {
	pool.drain();
	layout.resetIndex();
	pool.shuffleRequestAll();
}
