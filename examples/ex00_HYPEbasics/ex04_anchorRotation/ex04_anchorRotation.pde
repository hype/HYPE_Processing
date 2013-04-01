HRect s1, s2, s3;
HEllipse s4, s5, s6;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();
	
	s1 = new HRect(90);
	s1
		.rounding(5)
		.fill(#FF3300)
		.anchorAt(H.CENTER)
		.loc(100,180)
		.extras(
			new HBundle()
			.num( "letsRotate", 1f )
		);
	H.add(s1);

	s2 = new HRect(90);
	s2
		.rounding(5)
		.fill(#FF6600)
		.loc(320,180)
		.extras(
			new HBundle()
			.num( "letsRotate", 1f )
		);
	H.add(s2);

	s3 = new HRect(90);
	s3
		.rounding(5)
		.fill(#FF9900)
		.anchor( new PVector(50,25) )
		.loc(width - 100,180)
		.extras(
			new HBundle()
			.num( "letsRotate", 1f )
		);
	H.add(s3);

	s4 = new HEllipse(25);
	s4.fill(#CCCCCC).anchor( new PVector(12.5,75) ).loc(100,height-180).extras(new HBundle().num( "letsRotate", random(-2,-1) ));
	H.add(s4);

	s5 = new HEllipse(25);
	s5.fill(#CCCCCC).anchor( new PVector(12.5,75) ).loc(width/2,height-180).extras(new HBundle().num( "letsRotate", random(-4,-2) ));
	H.add(s5);

	s6 = new HEllipse(25);
	s6.fill(#CCCCCC).anchor( new PVector(12.5,75) ).loc(width-100,height-180).extras(new HBundle().num( "letsRotate", random(-8,-4) ));
	H.add(s6);
}

void draw() {
	HBundle e1 = s1.extras(); s1.rotate(e1.num("letsRotate"));
	HBundle e2 = s2.extras(); s2.rotate(e2.num("letsRotate"));
	HBundle e3 = s3.extras(); s3.rotate(e3.num("letsRotate"));

	HBundle e4 = s4.extras(); s4.rotate(e4.num("letsRotate"));
	HBundle e5 = s5.extras(); s5.rotate(e5.num("letsRotate"));
	HBundle e6 = s6.extras(); s6.rotate(e6.num("letsRotate"));

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