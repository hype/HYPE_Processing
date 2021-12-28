import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HPath star1 = new HPath();
	star1
		.star( 5, 0.75 ) // numEdges, depth
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF9900)
		.loc(50, 50)
	;
	H.add(star1);

	HPath star2 = new HPath();
	star2
		.star( 5, 0.5 ) // numEdges, depth
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF6600)
		.loc(245, 50)
	;
	H.add(star2);

	HPath star3 = new HPath();
	star3
		.star( 5, 0.25 ) // numEdges, depth
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF3300)
		.loc(440, 50)
	;
	H.add(star3);


	HPath star4 = new HPath();
	star4.star( 7, 0.75 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF9900).loc(50, 245);
	H.add(star4);

	HPath star5 = new HPath();
	star5.star( 7, 0.5 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF6600).loc(245, 245);
	H.add(star5);

	HPath star6 = new HPath();
	star6.star( 7, 0.25 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF3300).loc(440, 245);
	H.add(star6);


	HPath star7 = new HPath();
	star7.star( 9, 0.75 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF9900).loc(50, 440);
	H.add(star7);

	HPath star8 = new HPath();
	star8.star( 9, 0.5 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF6600).loc(245, 440);
	H.add(star8);

	HPath star9 = new HPath();
	star9.star( 9, 0.25 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF3300).loc(440, 440);
	H.add(star9);

	H.drawStage();
	noLoop();
}

void draw() {

}
