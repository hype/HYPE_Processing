import hype.*;
import hype.extended.behavior.HRandomTrigger;
import hype.extended.behavior.HTimer;
import hype.extended.behavior.HTween;
import hype.extended.colorist.HColorPool;

HColorPool colors;
HCanvas    canvas;

void setup() {
	size(640,640);
	H.init(this).background(#000000);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	H.add(canvas = new HCanvas()).autoClear(false).fade(1);

	final HRandomTrigger tweenTrigger = new HRandomTrigger( 1f/6 );

	tweenTrigger.callback(
		new HCallback(){
			public void run(Object obj) {
				final HDrawable r = canvas.add(new HRect(25+((int)random(5)*25)).rounding(10))
					.strokeWeight(1)
					.stroke(colors.getColor())
					.fill(#000000, 25)
					.loc((int)random(width), (int)random(height))
					.anchorAt(H.CENTER)
				;

				final HTween tween1 = new HTween()
					.target(r).property(H.SCALE)
					.start(0).end(1).ease(0.03).spring(0.95)
				;

				final HTween tween2 = new HTween()
					.target(r).property(H.ROTATION)
					.start(-90).end(90).ease(0.01).spring(0.7)
				;

				final HTween tween3 = new HTween()
					.target(r).property(H.ALPHA)
					.start(0).end(255).ease(0.1).spring(0.95)
				;

				r.scale(0).rotation(-90).alpha(0);

				final HTimer timer = new HTimer().interval(250).unregister();

				// tween has appeared / start timer

				final HCallback onAppear = new HCallback() {
					public void run(Object obj) {
						timer.register();
					}
				};

				// on screen pause is finished lets remove

				final HCallback onDisappear = new HCallback() {
					public void run(Object obj) {
						canvas.remove(r);
					}
				};

				// timer starts / holds art on screen for 250 miliseconds / then calls onDisappear

				final HCallback onPause = new HCallback() {
					public void run(Object obj) {
						timer.unregister();
						tween1.start(1).end(2).ease(0.01).spring(0.99).register();
						tween2.start(90).end(-90).ease(0.01).spring(0.7).register();
						tween3.start(255).end(0).ease(0.01).spring(0.95).register().callback(onDisappear);
					}
				};

				tween3.callback(onAppear);
				timer.callback(onPause);
			}
		}
	);
}

void draw() {
	H.drawStage();
}
