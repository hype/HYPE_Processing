import hype.*;
import hype.extended.behavior.HOrbiter3D;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;

HDrawablePool pool;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	pool = new HDrawablePool(400);
	pool.autoAddToStage()
		.add(new HSprite(50,50).texture(new HImage("tex1.png")))
		.add(new HSprite(50,50).texture(new HImage("tex2.png")))
		.add(new HSprite(50,50).texture(new HImage("tex3.png")))

		// HSprite is the fastest possible drawable, perfect for drawing thousands of objects on screen and not killing FPS
		// PNG's also create interesting "overlapping" textures through the transparency
		// and if the PNG's use white... they can be "perfectly" tinted on the fill()
		// if the PNG is grayscale/color fill() coloring is applied ON TOP of base color, only white creates 1 to 1 tinting

		.colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC, #999999, #666666, #4D4D4D, #333333, #FF3300, #FF6600).fillOnly() )
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HDrawable d = (HDrawable) obj;
					d.anchorAt(H.CENTER).rotation(45);

					HOrbiter3D orb = new HOrbiter3D(width/2, height/2, 0)
						.target(d)
						.radius(225)
						.ySpeed(1)
						.zSpeed(1)
						.yAngle( (i+1)*2 )
						.zAngle( (i+1)*3 )
					;

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0.1, 1.0)
						.speed(0.1)
						.freq(10)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(-180, 180)
						.speed(0.1)
						.freq(10)
						.currentStep(i)
					;
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
	surface.setTitle(int(frameRate) + " fps");
}
