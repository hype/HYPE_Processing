import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HTimer;
import hype.extended.behavior.HTween;
import hype.extended.behavior.HOscillator;

HColorPool    colors;
HCanvas       canvas;
HDrawablePool pool;
HCallback     onTweenEnd;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333,#0095A8, #00616F, #FF3300, #FF6600);

	canvas = (HCanvas) H.add(new HCanvas(P3D).autoClear(false).fade(2));

	onTweenEnd = new HCallback() {
		public void run(Object obj) {
			HTween tween = (HTween) obj;
			pool.release(tween.target());
		}
	};

	pool = new HDrawablePool(300);
	pool.autoParent(canvas)
		.add(new HRect(10).rounding(20))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill(colors.getColor())
						.scale(0)
						.obj("tween", new HTween()
							.target(d)
							.property(H.Z)
							.ease(.0005)
							.spring(.97)
							.callback(onTweenEnd)
						)
						.obj("oscR", new HOscillator()
							.property(H.ROTATION)
							.waveform(H.SINE)
							.speed(0.3)
							.freq(2)
							.range( -(int)random(180,360) , (int)random(180,360) )
						)
						.obj("oscS", new HOscillator()
							.property(H.SCALE)
							.waveform(H.SINE)
							.speed(0.75)
							.freq(4)
							.range(0.2,2.0)
						)
					;
				}
			}
		)

		.onRequest(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;

					HTween tween = (HTween) d.obj("tween");
					HOscillator oscR = (HOscillator) d.obj("oscR");
					HOscillator oscS = (HOscillator) d.obj("oscS");

					d.loc(random(width), random(height), random(-2000)).size(HMath.randomInt(1,11)*5);

					tween.register().start(d.z()).end(100);
					oscR.register().currentStep(i*2).target(d);
					oscS.register().currentStep(i*2).target(d);
				}
			}
		)

		.onRelease(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					HOscillator oscR = (HOscillator) d.obj("oscR");
					HOscillator oscS = (HOscillator) d.obj("oscS");
					
					oscR.unregister();
					oscS.unregister();
				}
			}
		)
	;

	new HTimer(100).callback(
		new HCallback() {
			public void run(Object obj){
				pool.request();
			}
		}
	);
}

void draw() {
	H.drawStage();
}
