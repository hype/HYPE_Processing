import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HPath poly1 = new HPath();
	poly1
		.polygon( 3 ) // numEdges
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF9900)
		.loc(50, 50)
	;
	H.add(poly1);

	HPath poly2 = new HPath();
	poly2
		.polygon( 4 ) // numEdges
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF6600)
		.loc(245, 50)
	;
	H.add(poly2);

	HPath poly3 = new HPath();
	poly3
		.polygon( 5 ) // numEdges
		.size(150,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF3300)
		.loc(440, 50)
	;
	H.add(poly3);


	HPath poly4 = new HPath();
	poly4.polygon( 6 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF9900).loc(50, 245);
	H.add(poly4);

	HPath poly5 = new HPath();
	poly5.polygon( 7 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF6600).loc(245, 245);
	H.add(poly5);

	HPath poly6 = new HPath();
	poly6.polygon( 8 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF3300).loc(440, 245);
	H.add(poly6);


	HPath poly7 = new HPath();
	poly7.polygon( 9 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF9900).loc(50, 440);
	H.add(poly7);

	HPath poly8 = new HPath();
	poly8.polygon( 10 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF6600).loc(245, 440);
	H.add(poly8);

	HPath poly9 = new HPath();
	poly9.polygon( 11 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF3300).loc(440, 440);
	H.add(poly9);

	H.drawStage();
	noLoop();
}

void draw() {

}
