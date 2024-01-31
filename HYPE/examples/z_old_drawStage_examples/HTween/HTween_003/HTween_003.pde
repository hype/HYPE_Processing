import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.behavior.HTween;
import hype.extended.colorist.HPixelColorist;

HPixelColorist colors;
HRect          r1;
HTween         tween;
HCallback      tr, br, bl, tl;
int            marginOffset = 150;
float          tweenEase    = 0.01;
float          tweenSpeed   = 0.9;

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(false);

	colors = new HPixelColorist("color.jpg").fillOnly();

	H.add(r1 = new HRect(100)).rounding(10).stroke(#000000, 100).fill(#FF3300).anchor(50,-50).loc(marginOffset,marginOffset).rotation(45);

	new HOscillator().target(r1).property(H.ROTATION).range(-180, 180).speed(1).freq(2);
	new HOscillator().target(r1).property(H.SCALE).range(0.2, 1).speed(0.5).freq(15);

	// tween from center to TL corner

	tween = new HTween().target(r1).property(H.LOCATION).start(r1.x(), r1.y()).end(marginOffset, marginOffset).ease(1).spring(0);

	// tween from TL to TR corner

	tr = new HCallback() {
		public void run(Object obj) {
			tween.start( r1.x(), r1.y() ).end( width-marginOffset, marginOffset ).ease(tweenEase).spring(tweenSpeed).register().callback(br);
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
	colors.applyColor(r1);
	H.drawStage();
}
