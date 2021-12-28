import hype.*;
import hype.extended.behavior.HTimer;
import hype.extended.behavior.HTween;
import hype.extended.colorist.HColorPool;

HDrawablePool pool;
HCanvas       canvas;
HColorPool    colors;
HTimer        timer;

int           numItems      = 4;

int[]         yPosTop       = new int[numItems];
int[]         yPosBot       = new int[numItems];

boolean[]     tweenToggle   = new boolean[numItems];
String[]      tweenState    = new String[numItems];

int[]         animDelayInit = new int[numItems];
int[]         animDelay     = new int[numItems];

// ************************************************************************************

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(true);

	H.add( canvas = new HCanvas() ).autoClear(false).fade(5);

	colors = new HColorPool(#FFFFFF, #666666, #0095a8, #FF3300);

	pool = new HDrawablePool(numItems);
	pool.autoParent(canvas)
		.add(new HRect(100).rounding(10))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					int i = pool.currentIndex();

					// set init array vars

					yPosTop[i]       = 100;
					yPosBot[i]       = height-100;
					tweenToggle[i]   = false;
					tweenState[i]    = "u";
					animDelayInit[i] = 50;
					animDelay[i]     = animDelayInit[i];

					d.strokeWeight(0).noStroke().fill( colors.getColorAt(i) ).loc( 95+(i * 150), yPosTop[i] ).rotation(45).anchorAt(H.CENTER);

					// tween down

					HTween tD = new HTween()
						.target(d).property(H.LOCATION)
						.start( d.x(), d.y() )
						.end( d.x(), yPosBot[i] )
						.ease(0.01)
						.spring(0.9)
					;

					// tween up

					HTween tU = new HTween()
						.target(d).property(H.LOCATION)
						.start( d.x(), yPosBot[i] )
						.end( d.x(), yPosTop[i] )
						.ease(0.01)
						.spring(0.9)
					;

					// callback fires when tU or tD reaches their end destination

					HCallback tweenDone = new HCallback() {
						int i = pool.currentIndex();
						public void run(Object obj) {
							tweenToggle[i] = true; // this will set tweenToggle from false to true - letting the system know, we've reached our destination and to animate the other direction
						}
					};

					tD.register().callback(tweenDone);
					tU.unregister().callback(tweenDone);

					d.extras( new HBundle().obj("tD", tD).obj("tU", tU) ); // this creates a "path" to the behavior associated with this object
				}
			}
		)
	;

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(200)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					pool.request();
				}
			}
		)
	;
}

void draw() {
	H.drawStage();

	int i = 0;

	for (HDrawable d : pool) {
		HBundle obj = d.extras();
		HTween tD = (HTween)obj.obj("tD");
		HTween tU = (HTween)obj.obj("tU");

		if (tweenToggle[i]) {
			if (tweenState[i]=="d") {
				if (animDelay[i]<=0) {
					tD.register();       // turn down tween on
					tU.unregister();     // turn up tween off

					tweenState[i] = "u"; // set state to go UP when tweenToggle fires again
					animDelay[i] = animDelayInit[i];
					tweenToggle[i] = false;
				}
			} else {
				if (animDelay[i]<=0) {
					tD.unregister();     // turn down tween off
					tU.register();       // turn up tween on

					tweenState[i] = "d"; // set state to go DOWN when tweenToggle fires again
					animDelay[i] = animDelayInit[i];
					tweenToggle[i] = false;
				}
			}
			if (tweenToggle[i]) animDelay[i]--;
		}
		i++;
	}
}
