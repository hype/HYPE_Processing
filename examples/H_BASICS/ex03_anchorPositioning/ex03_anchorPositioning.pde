void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	// anchorAt() will take any combination of the ff:
	// - H.LEFT
	// - H.CENTER_X -- equals to (H.LEFT | H.RIGHT)
	// - H.RIGHT
	// - H.TOP
	// - H.CENTER_Y -- equals to (H.TOP | H.BOTTOM)
	// - H.BOTTOM
	// - H.CENTER -- equals to (H.CENTER_X | H.CENTER_Y)
	
	HRect s1 = new HRect(100);
	s1
		.rounding(5)
		.noStroke()
		.fill(#ECECEC)
		.anchorAt(H.CENTER)
		.loc(width/2,height/2)
	;
	H.add(s1);

	HRect s2 = new HRect(100);
	s2
		.rounding(5)
		.noStroke()
		.fill(#FF3300)
		.anchorAt(H.TOP|H.LEFT)
		.loc(50,50)
	;
	H.add(s2);

	HRect s3 = new HRect(100);
	s3
		.rounding(5)
		.noStroke()
		.fill(#FF6600)
		.anchorAt(H.TOP|H.RIGHT)
		.loc(width - 50,50)
	;
	H.add(s3);

	HRect s4 = new HRect(100);
	s4
		.rounding(5)
		.noStroke()
		.fill(#FF9900)
		.anchorAt(H.BOTTOM|H.RIGHT)
		.loc(width - 50,height - 50)
	;
	H.add(s4);

	HRect s5 = new HRect(100);
	s5
		.rounding(5)
		.noStroke()
		.fill(#FFCC00)
		.anchorAt(H.BOTTOM|H.LEFT)
		.loc(50,height - 50)
	;
	H.add(s5);

	H.drawStage();
	noLoop();

	// using ellipse to mark the moved registration points

	noFill(); strokeWeight(2); stroke(#0095a8);
	
	ellipse(width/2, height/2, 4, 4);
	ellipse(50, 50, 4, 4);
	ellipse(width-50, 50, 4, 4);
	ellipse(width-50, height - 50, 4, 4);
	ellipse(50, height-50, 4, 4);
}

void draw() {}

