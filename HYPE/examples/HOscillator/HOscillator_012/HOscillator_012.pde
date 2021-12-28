import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.behavior.HTimer;
import hype.extended.colorist.HColorPool;

HDrawablePool pool;
HColorPool    colors = new HColorPool(#111111, #202020, #242424, #333333, #4D4D4D, #CCCCCC);

void setup() {
	size(640,640);
	H.init(this).background(#000000);

	PFont type = createFont("DroidSerifBoldItalic.ttf", 24);

	pool = new HDrawablePool(1000);
	pool.autoAddToStage()
		.add(new HRect().rounding(5))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HDrawable d = (HDrawable) obj;
					d
						.strokeWeight(8)
						.stroke(#FFFFFF, 10)
						.strokeCap(ROUND)
						.strokeJoin(ROUND)
						.fill(colors.getColor())
						.size( (int)random(4,10)  , (int)random(8,12) )
						.loc(  (int)random(width) , (int)random(height) )
						.anchorAt(H.CENTER)

						.obj("xo", new HOscillator()
							.target(d)
							.property(H.X)
							.relativeVal(d.x())
							.range(-(int)random(5,10), (int)random(5,10))
							.speed( random(.005,.2) )
							.freq(10)
							.currentStep(i)
						)

						.obj("ao", new HOscillator()
							.target(d)
							.property(H.ALPHA)
							.range(0,255)
							.speed( random(.3,.9) )
							.freq(5)
							.currentStep(i)
						)

						.obj("wo", new HOscillator()
							.target(d)
							.property(H.WIDTH)
							.range(-d.width(),d.width())
							.speed( random(.05,.2) )
							.freq(10)
							.currentStep(i)
						)

						.obj("ro", new HOscillator()
							.target(d)
							.property(H.ROTATION)
							.range(-180,180)
							.speed( random(.005,.05) )
							.freq(10)
							.currentStep(i)
						)
					;
				}
			}
		)

		.onRequest(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.scale(1).alpha(0).loc((int)random(width),(int)random(height));

					HOscillator xo = (HOscillator) d.obj("xo"); xo.register();
					HOscillator ao = (HOscillator) d.obj("ao"); ao.register();
					HOscillator wo = (HOscillator) d.obj("wo"); wo.register();
					HOscillator ro = (HOscillator) d.obj("ro"); ro.register();
				}
			}
		)

		.onRelease(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					HOscillator xo = (HOscillator) d.obj("xo"); xo.unregister();
					HOscillator ao = (HOscillator) d.obj("ao"); ao.unregister();
					HOscillator wo = (HOscillator) d.obj("wo"); wo.unregister();
					HOscillator ro = (HOscillator) d.obj("ro"); ro.unregister();
				}
			}
		)
	;

	new HTimer(50)
		.callback(
			new HCallback() {
				public void run(Object obj) {
					pool.request();
				}
			}
		)
	;

	HText f1 = new HText("dust",200,type);
	f1.fill(#ECECEC).anchorAt(H.CENTER).loc(width/2,height/2);
	H.add(f1);
}

void draw() {
  for(HDrawable d : pool) {
		d.loc( d.x(), d.y() - random(0.25,1) );

		if (d.y() < -40) pool.release(d);
	}

	H.drawStage();
}
