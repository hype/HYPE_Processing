/*
	Demo using pixelColorist to color the shapes, 
	and Color Lightness behavior to control the rotation of them
*/


import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HColorLightness;
import hype.extended.colorist.HPixelColorist;

HDrawablePool pool;
PImage img;

void setup() {
	noLoop();
	size(640, 640);
	H.init(this).background(#000000);
	smooth();

	final HPixelColorist colors = new HPixelColorist("orange_ball.png").fillOnly();

	img = loadImage("orange_ball.png");

	pool = new HDrawablePool(1024);
	pool.autoAddToStage()
		.add(
			new HRect(20, 5)
				.rounding(2)
				.anchorAt(H.CENTER)
				.noStroke()
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

					new HColorLightness(img)
						.property(H.ROTATION)
						//.useBrightness()
						.range(0, 90)
						.target(d)
					;

					colors.applyColor(d);
					
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
}

void draw() {
}

