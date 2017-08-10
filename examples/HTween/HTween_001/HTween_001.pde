import hype.*;
import hype.extended.behavior.HTween;

HRect  r1, r2, r3;

HTween t1a;
HTween t2a, t2b;
HTween t3a, t3b, t3c, t3d;

void setup() {
	size(640,640);
	H.init(this).background(#242424).autoClear(false);

	// Rect 1 and tween

	r1 = new HRect(100).rounding(10);
	r1
		.stroke(#000000, 100)
		.fill(#FF9900)
		.anchorAt(H.CENTER)
		.loc(125,125)
		.rotation(45)
	;
	H.add(r1);

	t1a = new HTween()
		.target(r1).property(H.LOCATION)
		.start( r1.x(), r1.y() )
		.end( r1.x(), height - 125 )
		.ease(0.005)
		.spring(0.95)
	;

	// Rect 2 and tweens

	H.add(r2 = new HRect(100)).rounding(10).stroke(#000000, 100).fill(#FF6600).anchorAt(H.CENTER).loc(width/2,125).rotation(45);

	t2a = new HTween().target(r2).property(H.LOCATION).start( r2.x(), r2.y() ).end( r2.x(), height - 125 ).ease(0.005).spring(0.95);
	t2b = new HTween().target(r2).property(H.SCALE).start(0).end(1).ease(0.005).spring(0.95);

	// Rect 3 and tweens

	H.add(r3 = new HRect(100)).rounding(10).stroke(#000000, 100).fill(#FF3300).anchorAt(H.CENTER).loc(width-125,125).rotation(45);

	t3a = new HTween().target(r3).property(H.LOCATION).start( r3.x(), r3.y() ).end( r3.x(), height - 125 ).ease(0.005).spring(0.95);
	t3b = new HTween().target(r3).property(H.SCALE).start(0).end(1).ease(0.005).spring(0.95);
	t3c = new HTween().target(r3).property(H.ALPHA).start(0).end(255).ease(0.005).spring(0.95);
	t3d = new HTween().target(r3).property(H.ROTATION).start(-45).end(405).ease(0.005).spring(0.95);
}

void draw() {
	H.drawStage();
}
