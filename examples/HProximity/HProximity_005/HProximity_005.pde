import hype.*;

void setup() {
	size(640, 640);
	H.init(this).background(#242424);

	HCanvas c = new HCanvas().autoClear(false).fade(5);
	H.add(c);

	HRect r1 = new HRect().rounding(4);
	r1.fill(#FFFFFF).size(10).loc(width/2, height/2);
	//c.add(r1);

	HRect r2 = new HRect().rounding(4);
	r2.noStroke().fill(#FF4400).size(5, 10).x(40).y(height/2).anchorAt(H.CENTER);
	c.add(r2);

	new HOscillator()
		.target(r2)
		.property(H.X)
		.range(40, 600)
		.speed(5)
		.freq(0.5)
		.currentStep(-180)
	;


	new HProximity(0.99, 0.7, 10, 200, 250)
		.target(r2)
		.neighbor(r1)
		.property(HConstants.HEIGHT);
}

void draw() {
	H.drawStage();

	//outline to show area of proximity
	noFill();
	stroke(#444444);
	ellipseMode(CENTER);
	ellipse(width/2, height/2, 500, 500);

}
