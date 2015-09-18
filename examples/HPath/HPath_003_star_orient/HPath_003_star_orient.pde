import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HPath star1 = new HPath();
	star1
		.star( 5, 0.5, 0 ) // numEdges, depth, orientation
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF9900)
		.loc(50, 245)
	;
	H.add(star1);

	HPath star2 = new HPath();
	star2
		.star( 5, 0.5, -90 ) // numEdges, depth, orientation
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF6600)
		.loc(245, 245)
	;
	H.add(star2);

	HPath star3 = new HPath();
	star3
		.star( 5, 0.5, 90 ) // numEdges, depth, orientation
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF3300)
		.loc(440, 245)
	;
	H.add(star3);

	H.drawStage();
	noLoop();

	fill(#FF3300);
	textSize(18); text("Heavy Metal", 463, 443);
}

void draw() {

}
