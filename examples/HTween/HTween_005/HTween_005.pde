import hype.*;
import hype.extended.behavior.HRandomTrigger;
import hype.extended.behavior.HTimer;
import hype.extended.behavior.HTween;
import hype.extended.colorist.HColorPool;

HColorPool     colors;
HRandomTrigger tweenTrigger;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	HRandomTrigger tweenTrigger = new HRandomTrigger(5f/15);

	tweenTrigger.callback(
		new HCallback() {
			public void run(Object obj) {
				float size = 25 * HMath.randomInt(1,6);
				float locx = HMath.randomInt(width);
				float locy = HMath.randomInt(height);

				final HDrawable r = H.add(new HRect(size).rounding(10)).noStroke().fill(colors.getColor()).loc(locx,locy).anchorAt(H.CENTER).rotation(45);

				final HTween tween = new HTween()
					.target(r).property(H.SCALE)
					.start(0).end(1)
					.ease(0.03).spring(0.95)
				;

				// set initial HRect scale to 0
				r.scale(0);

				final HTimer timer = new HTimer().interval(3000).unregister();

				// tween has appeared / start timer
				final HCallback onAppear = new HCallback() {
					public void run(Object obj) {
						timer.register();
					}
				};

				// on screen pause is finished lets remove
				final HCallback onDisappear = new HCallback() {
					public void run(Object obj) {
						H.remove(r);
					}
				};

				// timer starts / holds art on screen for 3 seconds / then calls onDisappear
				final HCallback onPause = new HCallback() {
					public void run(Object obj) {
						timer.unregister();
						tween.start(1).end(0).ease(0.1).spring(0.7).register().callback(onDisappear);
					}
				};

				tween.callback(onAppear);
				timer.callback(onPause);
			}
		}
	);
}

void draw() {
	H.drawStage();
}
