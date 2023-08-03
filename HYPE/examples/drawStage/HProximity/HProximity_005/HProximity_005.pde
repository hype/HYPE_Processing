import hype.*;
import hype.extended.behavior.HProximity;
import hype.extended.behavior.HOscillator;

void setup() {
	size(640, 640);
	H.init(this).background(#242424);

	HCanvas canvas = H.add(new HCanvas().autoClear(false).fade(5));

	HRect r1 = new HRect(5);
	r1.noStroke().fill(#00FF00).loc(width/2, height/2).rotate(45).anchorAt(H.CENTER);
	canvas.add(r1);

	HRect r2 = new HRect(5,10).rounding(4);
	r2.noStroke().fill(#FF3300).x(40).y(height/2).anchorAt(H.CENTER);
	canvas.add(r2);

	new HProximity()
		.target(r2)
		.neighbor(r1)
		.property(H.HEIGHT)
		.spring(0.99)
		.ease(0.7)
		.min(10)
		.max(200)
		.radius(250)
	;

	new HOscillator().target(r2).property(H.X).range(40, 600).speed(5).freq(0.5).currentStep(-180);
}

void draw() {
	H.drawStage();

	//outline to show area of proximity
	
	ellipseMode(CENTER);
	stroke(#4D4D4D);
	noFill();
	ellipse(width/2, height/2, 500, 500);
}
