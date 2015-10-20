import hype.*;
import hype.extended.behavior.HRotate;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HDrawable rect1 = H.add(new HRect(100)).rounding(10).anchorAt(H.CENTER).x(125).locAt(H.CENTER_Y).noStroke().fill(#FF9900);
	HDrawable rect2 = H.add(new HRect(100)).rounding(10).anchorAt(H.CENTER).x(width/2).locAt(H.CENTER_Y).noStroke().fill(#FF6600);
	HDrawable rect3 = H.add(new HRect(100)).rounding(10).anchorAt(H.CENTER).x(width-125).locAt(H.CENTER_Y).noStroke().fill(#FF3300);

	// This sets rect1 to rotate 2 degrees every time H.drawStage() is called

	HRotate rot1 = new HRotate();
	rot1.target(rect1).speed( 2 );

	// There is also a radians version of the speed() method:

	HRotate rot2 = new HRotate();
	rot2.target(rect2).speedRad( TWO_PI/90 );

	// Alternatively, you can use HRotate this way: (target, speed)
	new HRotate(rect3, -0.5);
}

void draw() {
	H.drawStage();
}
