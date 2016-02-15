import hype.*;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HRect(70).rounding(5).anchorAt(H.CENTER).rotation(45))
		.layout(new HGridLayout().startX(32).startY(32).spacing(64,64).cols(10))
		.shuffleRequestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {

}
