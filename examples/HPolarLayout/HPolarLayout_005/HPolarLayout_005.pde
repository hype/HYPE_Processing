import hype.*;
import hype.extended.layout.HPolarLayout;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HDrawablePool pool = new HDrawablePool(1100);
	pool.autoAddToStage()
		.add(new HRect(10).rounding(3).noStroke().fill(#FF3300).anchorAt(H.CENTER))

		.layout(
			new HPolarLayout(0.25, 10)
			.offset(width/2, height/2)
			.scale(0.005)
		)

		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {
	
}
