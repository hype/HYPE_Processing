import hype.*;
import hype.extended.behavior.HColorLightness;
import hype.extended.colorist.HPixelColorist;
import hype.extended.layout.HGridLayout;

HDrawablePool  pool;
HPixelColorist colors;
PImage         img;

void setup() {
	size(640, 640);
	H.init(this).background(#242424);

	// img = loadImage("gradient_ball.png");
	// img = loadImage("orange_ball.png");
	// img = loadImage("skull.png");
	img = loadImage("testplate.png");

	// Demo using pixelColorist to color the shapes, and Color Lightness behavior to control the rotation of them

	colors = new HPixelColorist(img).fillOnly();

	pool = new HDrawablePool(1024);
	pool.autoAddToStage()
		.add(new HRect(20, 5).rounding(2).noStroke().anchorAt(H.CENTER))
		.layout(new HGridLayout().startLoc(10, 10).spacing(20, 20).cols(32))
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
}

void draw() {
	H.drawStage();
}
