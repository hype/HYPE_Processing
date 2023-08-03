import hype.*;
import hype.extended.behavior.HColorLightness;
import hype.extended.layout.HGridLayout;

HDrawablePool poolBright, poolLight;
PImage        img;

void setup() {
	size(640, 640);
	H.init(this).background(#242424);

	// Demonstrates the difference between lightness and brightness. The Pokeball is unintentional.

	img = loadImage("orange_ball.png");

	poolBright = new HDrawablePool(528);
	poolBright.autoAddToStage()
		.add(new HEllipse(10).noStroke().fill(#FF3300).anchorAt(H.CENTER))
		.layout(new HGridLayout().startLoc(630, 630).spacing(-20, -20).cols(32))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					new HColorLightness(img)
						.useBrightness()
						.property(H.SCALE)
						.range(0, 1)
						.target(d)
					;
					
				}
			}
		)
		.requestAll()
	;

	poolLight = new HDrawablePool(528);
	poolLight.autoAddToStage()
		.add(new HEllipse(10).noStroke().fill(#FFFFFF).anchorAt(H.CENTER))
		.layout(new HGridLayout().startLoc(10, 10).spacing(20, 20).cols(32))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					new HColorLightness(img)
						.useLightness() // lightness is the default
						.property(H.SCALE)
						.range(0, 1)
						.target(d)
					;
					
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
