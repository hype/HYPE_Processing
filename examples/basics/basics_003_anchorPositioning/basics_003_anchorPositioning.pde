import hype.*;

int stageMargin = 100;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

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

// ************************************************************************************

	HRect s2 = new HRect(100);
	s2
		.rounding(5)
		.noStroke()
		.fill(#FF3300)
		.anchorAt(H.TOP|H.LEFT)
		.loc(stageMargin,stageMargin)
	;
	H.add(s2);

	HRect s3 = new HRect(100);
	s3
		.rounding(5)
		.noStroke()
		.fill(#FF6600)
		.anchorAt(H.TOP|H.RIGHT)
		.loc(width - stageMargin,stageMargin)
	;
	H.add(s3);

	HRect s4 = new HRect(100);
	s4
		.rounding(5)
		.noStroke()
		.fill(#FF9900)
		.anchorAt(H.BOTTOM|H.RIGHT)
		.loc(width - stageMargin,height - stageMargin)
	;
	H.add(s4);

	HRect s5 = new HRect(100);
	s5
		.rounding(5)
		.noStroke()
		.fill(#FFCC00)
		.anchorAt(H.BOTTOM|H.LEFT)
		.loc(stageMargin,height - stageMargin)
	;
	H.add(s5);

// ************************************************************************************

	HRect s6 = new HRect(100);
	s6
		.rounding(5)
		.noStroke()
		.fill(#006600)
		.anchorAt(H.LEFT|H.CENTER_Y)
		.loc(stageMargin,height/2)
	;
	H.add(s6);

	HRect s7 = new HRect(100);
	s7
		.rounding(5)
		.noStroke()
		.fill(#009900)
		.anchorAt(H.CENTER_X|H.TOP)
		.loc(width/2,stageMargin)
	;
	H.add(s7);

	HRect s8 = new HRect(100);
	s8
		.rounding(5)
		.noStroke()
		.fill(#00CC00)
		.anchorAt(H.RIGHT|H.CENTER_Y)
		.loc(width-stageMargin,height/2)
	;
	H.add(s8);

	HRect s9 = new HRect(100);
	s9
		.rounding(5)
		.noStroke()
		.fill(#00FF00)
		.anchorAt(H.CENTER_X|H.BOTTOM)
		.loc(width/2,height-stageMargin)
	;
	H.add(s9);

// ************************************************************************************

	H.drawStage();
	noLoop();

	// using ellipse to mark the moved registration points

	strokeWeight(2); stroke(#0095a8); fill(#333333); 
	
	ellipse(s1.x(), s1.y(), 6, 6);
	ellipse(s2.x(), s2.y(), 6, 6);
	ellipse(s3.x(), s3.y(), 6, 6);
	ellipse(s4.x(), s4.y(), 6, 6);
	ellipse(s5.x(), s5.y(), 6, 6);
	ellipse(s6.x(), s6.y(), 6, 6);
	ellipse(s7.x(), s7.y(), 6, 6);
	ellipse(s8.x(), s8.y(), 6, 6);
	ellipse(s9.x(), s9.y(), 6, 6);
}

void draw() {

}
