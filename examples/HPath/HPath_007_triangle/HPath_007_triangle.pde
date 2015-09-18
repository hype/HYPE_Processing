import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HPath triangle1 = new HPath();
	triangle1
		.triangle( H.ISOCELES, H.TOP ) // ISOCELES / type, direction
		.size(125,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF9900)
		.loc(50, 50)
	;
	H.add(triangle1);

	HPath triangle2 = new HPath();
	triangle2
		.triangle( H.ISOCELES, H.RIGHT ) // ISOCELES / type, direction
		.size(150,125)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF6600)
		.loc(245, 50)
	;
	H.add(triangle2);

	HPath triangle3 = new HPath();
	triangle3
		.triangle( H.ISOCELES, H.BOTTOM ) // ISOCELES / type, direction
		.size(125,150)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF3300)
		.loc(440, 50)
	;
	H.add(triangle3);

	// RIGHT / type, direction

	HPath triangle4 = new HPath();
	triangle4.triangle( H.RIGHT, H.TOP_LEFT ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF9900).loc(50, 245);
	H.add(triangle4);

	HPath triangle5 = new HPath();
	triangle5.triangle( H.RIGHT, H.TOP_RIGHT ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF6600).loc(245, 245);
	H.add(triangle5);

	HPath triangle6 = new HPath();
	triangle6.triangle( H.RIGHT, H.BOTTOM_LEFT ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF3300).loc(440, 245);
	H.add(triangle6);

	// EQUILATERAL / type, direction

	HPath triangle7 = new HPath();
	triangle7.triangle( H.EQUILATERAL, H.TOP ).size(150).strokeWeight(6).stroke(#000000, 100).fill(#FF9900).loc(50, 440);
	H.add(triangle7);

	HPath triangle8 = new HPath();
	triangle8.triangle( H.EQUILATERAL, H.RIGHT ).size(150).strokeWeight(6).stroke(#000000, 100).fill(#FF6600).loc(245, 440);
	H.add(triangle8);

	HPath triangle9 = new HPath();
	triangle9.triangle( H.EQUILATERAL, H.BOTTOM ).size(150).strokeWeight(6).stroke(#000000, 100).fill(#FF3300).loc(440, 440);
	H.add(triangle9);

	H.drawStage();
	noLoop();
}

void draw() {

}
