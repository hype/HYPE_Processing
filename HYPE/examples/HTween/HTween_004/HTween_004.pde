import hype.*;
import hype.extended.behavior.HRandomTrigger;
import hype.extended.behavior.HTween;
import hype.extended.colorist.HColorPool;

HColorPool     colors;
HRandomTrigger tweenTrigger;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	tweenTrigger = new HRandomTrigger(1f/15);

	tweenTrigger.callback(
		new HCallback(){
			public void run(Object obj) {
				final HDrawable r = H.add( new HRect(25+((int)random(5)*25)).rounding(10) )
					.noStroke()
					.fill(colors.getColor())
					.loc(width/2, height/2)
					.anchorAt(H.CENTER)
					.rotation(45)
				;

				final HTween tween = new HTween()
					.target(r)
					.property(H.LOCATION)
					.start(width/2, height/2)
					.end((int)random(width),(int)random(height))
					.ease(0.01)
					.spring(0.9)
				;
			}
		}
	);
}

void draw() {
	H.drawStage();
}
