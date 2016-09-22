import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HColorLightness;

HDrawablePool pool;
PImage img;

void setup() {
	noLoop();
	size(640, 640);
	H.init(this).background(#242424);
	smooth();

	//The image we are going to reference for lightness values
	// img = loadImage("gradient_ball.png");
	// img = loadImage("orange_ball.png");
	// img = loadImage("skull.png");
	img = loadImage("testplate.png");

	pool = new HDrawablePool(1024);
	pool.autoAddToStage()
		.add(
			new HEllipse(5)
				.anchorAt(H.CENTER)
				.noStroke()
				.fill(255)
		)

		.layout(
			new HGridLayout()
				.startLoc(10, 10)
				.spacing(20, 20)
				.cols(32)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					/*
						When using HColorLightness in a pool, it is more efficient to pass an instance of a PImage
						than to pass a file name.

						Passing the filename to the behaviour when using a pool results in much slower loading/running 
						as loadImage is called for every object in the pool i.e. new HColorLightness("testplate.png")
					*/

					new HColorLightness(img)
						.property(H.SCALE)
						.range(0.1, 2.0)
						.target(d)
					;
					
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
}

void draw() {
}
