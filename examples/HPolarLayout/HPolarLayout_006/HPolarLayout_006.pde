import hype.*;
import hype.extended.layout.HPolarLayout;

HDrawablePool pool;

int           colshifter = 0;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	pool = new HDrawablePool(1100);
	pool.autoAddToStage()
		.add(new HRect(10).rounding(3).noStroke().fill(#FFFFFF).anchorAt(H.CENTER))

		.layout (
			new HPolarLayout(0.25, 10)
			.offset(width/2, height/2)
			.scale(0.005)
		)

		.requestAll()
	;
}

void draw() {
	colorMode(HSB, 360, 100, 100);

	colshifter++;
	if (colshifter >360) colshifter=0;

	for (HDrawable d : pool) {
		color tempClr = color(colshifter, random(50, 100), random(75, 100));
		d.fill( tempClr );
	}

	H.drawStage();
}
