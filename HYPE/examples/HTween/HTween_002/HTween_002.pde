import hype.*;
import hype.extended.behavior.HTween;

HRect     r1;
HTween    tween;
HCallback tr, br, bl, tl;
int       marginOffset = 150;
float     tweenEase    = 0.01;
float     tweenSpeed   = 0.9;

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(true);

	H.add(r1 = new HRect(100)).rounding(10).stroke(#000000, 100).fill(#FF3300).anchorAt(H.CENTER).loc(width/2,height/2).rotation(45);

	// tween from center to TL corner

	tween = new HTween().target(r1).property(H.LOCATION).start(r1.x(), r1.y()).end(marginOffset, marginOffset).ease(tweenEase).spring(tweenSpeed);

	// tween from TL to TR corner

	tr = new HCallback() {
		public void run(Object obj) {
			tween.start(r1.x(), r1.y()).end(width-marginOffset, marginOffset).ease(tweenEase).spring(tweenSpeed).register().callback(br);
		}
	};

	// tween from TR to BR corner

	br = new HCallback() {
		public void run(Object obj) {
			tween.start( r1.x(), r1.y() ).end( width-marginOffset, height-marginOffset ).ease(tweenEase).spring(tweenSpeed).register().callback(bl);
		}
	};

	// tween from BR to BL corner

	bl = new HCallback() {
		public void run(Object obj) {
			tween.start( r1.x(), r1.y() ).end( marginOffset, height-marginOffset ).ease(tweenEase).spring(tweenSpeed).register().callback(tl);
		}
	};

	// tween from BL to TL corner

	tl = new HCallback() {
		public void run(Object obj) {
			tween.start( r1.x(), r1.y() ).end( marginOffset, marginOffset ).ease(tweenEase).spring(tweenSpeed).register().callback(tr);
		}
	};

	tween.register().callback(tr);
}

void draw() {
	H.drawStage();

	// using ellipse to mark the moved registration points

	strokeWeight(2); stroke(#0095a8); noFill();
	ellipse(150, 150, 4, 4);
	ellipse(width-150, 150, 4, 4);
	ellipse(width-150, height-150, 4, 4);
	ellipse(150, height-150, 4, 4);
	ellipse(width/2, height/2, 4, 4);
}
