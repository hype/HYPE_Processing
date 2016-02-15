import hype.*;
import hype.extended.behavior.HProximity;
import hype.extended.behavior.HFollow;

void setup() {
	size(640, 640);
	H.init(this).background(#242424);

	HRect r1 = new HRect(50);
	r1.noStroke().fill(#FF3300).loc(width/2, height/2).rotate(45).anchorAt(H.CENTER);
	H.add(r1);

	HRect r2 = new HRect(10);
	r2.noStroke().fill(#00FF00).loc(width/2, height/2).rotate(45).anchorAt(H.CENTER);
	H.add(r2);

	new HProximity()
		.target(r1)
		.neighbor(r2)
		.property(H.SCALE)
		.spring(0.95)
		.ease(0.4)
		.min(0.25)
		.max(1.5)
		.radius(250)
	;

	HFollow mf = new HFollow().target(r1);
}

void draw() {
	H.drawStage();

	//outline to show area of proximity
	
	ellipseMode(CENTER);
	stroke(#4D4D4D);
	noFill();
	ellipse(width/2, height/2, 500, 500);
}
