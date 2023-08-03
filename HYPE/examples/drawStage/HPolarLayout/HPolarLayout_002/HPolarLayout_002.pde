import hype.*;
import hype.extended.layout.HPolarLayout;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HDrawablePool pool = new HDrawablePool(300);
	pool.autoAddToStage()
		.add(new HRect(10).rounding(3).noStroke().fill(#FF3300).anchorAt(H.CENTER))

		.layout(
			new HPolarLayout(1, 0.2)
			.offset(width/2, height/2)
		)

		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {
	
}
