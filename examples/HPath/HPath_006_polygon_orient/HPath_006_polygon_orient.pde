import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HPath poly1 = new HPath();
	poly1
		.polygon( 5, 0 ) // numEdges, orientation
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF9900)
		.loc(50, 245)
	;
	H.add(poly1);

	HPath poly2 = new HPath();
	poly2
		.polygon( 5, -90 ) // numEdges, orientation
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF6600)
		.loc(245, 245)
	;
	H.add(poly2);

	HPath poly3 = new HPath();
	poly3
		.polygon( 5, 90 ) // numEdges, orientation
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF3300)
		.loc(440, 245)
	;
	H.add(poly3);

	H.drawStage();
	noLoop();
}

void draw() {

}
