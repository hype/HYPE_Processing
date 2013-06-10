HRect s1, s2, s3;
HEllipse s4, s5, s6;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();
	
	s1 = new HRect(90);
	s1
		.rounding(5)
		.noStroke()
		.fill(#FF3300)
		.anchorAt(H.CENTER)
		.loc(100,180)
	;
	H.add(s1);
	HRotate r1 = new HRotate(); r1.target(s1).speed(1);

	s2 = new HRect(90);
	s2
		.rounding(5)
		.noStroke()
		.fill(#FF6600)
		.loc(320,180)
	;
	H.add(s2);
	HRotate r2 = new HRotate(); r2.target(s2).speed(1);

	s3 = new HRect(90);
	s3
		.rounding(5)
		.noStroke()
		.fill(#FF9900)
		.anchor(50,25)
		.loc(width - 100,180)
	;
	H.add(s3);
	HRotate r3 = new HRotate(); r3.target(s3).speed(1);

	s4 = new HEllipse(25);
	s4.noStroke().fill(#CCCCCC).anchor(12.5,75).loc(100,height-180);
	H.add(s4);
	HRotate r4 = new HRotate(); r4.target(s4).speed(random(-2,-1));

	s5 = new HEllipse(25);
	s5.noStroke().fill(#CCCCCC).anchor(12.5,75).loc(width/2,height-180);
	H.add(s5);
	HRotate r5 = new HRotate(); r5.target(s5).speed(random(-4,-2));

	s6 = new HEllipse(25);
	s6.noStroke().fill(#CCCCCC).anchor(12.5,75).loc(width-100,height-180);
	H.add(s6);
	HRotate r6 = new HRotate(); r6.target(s6).speed(random(-8,-4));
}

void draw() {
	H.drawStage();

	// using ellipse to mark the moved registration points

	noFill(); strokeWeight(2); stroke(#0095a8);
	ellipse(100, 180, 4, 4);
	ellipse(width/2, 180, 4, 4);
	ellipse(width-100, 180, 4, 4);

	ellipse(100, height - 180, 4, 4);
	ellipse(width/2, height - 180, 4, 4);
	ellipse(width-100, height - 180, 4, 4);
}

