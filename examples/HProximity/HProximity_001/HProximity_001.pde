import hype.*;

void setup() {
	size(640, 640);
	H.init(this).background(#242424);

	HRect r1 = new HRect().rounding(4);
	r1.fill(#FF0000).size(10).loc(width/2, height/2);
	H.add(r1);

	HRect r2 = new HRect().rounding(4);
	r2.fill(#00FF00).size(50).loc(540, 100).anchorAt(H.CENTER);
	H.add(r2);

	new HProximity(0.95, 0.4, 0.5, 1.5, 250)
	.target(r2)
	.neighbor(r1)
	.property(HConstants.SCALE);

	HFollow mf = new HFollow().target(r2);
}

void draw() {
	H.drawStage();

	//outline to show area of proximity
	noFill();
	stroke(#444444);
	ellipseMode(CENTER);
	ellipse(width/2, height/2, 500, 500);

}
