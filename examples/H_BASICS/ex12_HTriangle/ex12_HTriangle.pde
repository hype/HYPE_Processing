void setup() {
	size(640,640);
	H.init(this).background(#242424);
	smooth();

	// We can also use `new HTriangle(H.ISOCELES)`

	HTriangle t1 = new HTriangle().type(H.ISOCELES);
	H.add(t1)
		.size(100,150)
		.noStroke()
		.fill(#FF9900)
		.loc(50, 50)
	;

	HTriangle t2 = new HTriangle().type(H.ISOCELES);
	H.add(t2).size(100,150).noStroke().fill(#FF6600).loc(245, 50);

	HTriangle t3 = new HTriangle().type(H.ISOCELES);
	H.add(t3).size(100,150).noStroke().fill(#FF3300).loc(440, 50);

	// We can also use `new HTriangle(H.RIGHT)`

	HTriangle t4 = new HTriangle().type(H.RIGHT);
	H.add(t4)
		.size(150,150)
		.noStroke()
		.fill(#FF9900)
		.loc(50, 245)
	;

	HTriangle t5 = new HTriangle().type(H.RIGHT);
	H.add(t5).size(150,150).noStroke().fill(#FF6600).loc(245, 245);

	HTriangle t6 = new HTriangle().type(H.RIGHT);
	H.add(t6).size(150,150).noStroke().fill(#FF3300).loc(440, 245);

	// We can also use `new HTriangle(H.EQUILATERAL)`

	// Equilateral mode is like isoceles mode, but if you
	// set the width, the height will automatically be set
	// so the sides will be equal.

	// Likewise, setting the height will also automatically
	// set the width.

	HTriangle t7 = new HTriangle().type(H.EQUILATERAL);
	H.add(t7)
		.size(150)
		.noStroke()
		.fill(#FF9900)
		.loc(50, 440)
	;

	HTriangle t8 = new HTriangle().type(H.EQUILATERAL);
	H.add(t8).size(150,150).noStroke().fill(#FF6600).loc(245, 440);

	HTriangle t9 = new HTriangle().type(H.EQUILATERAL);
	H.add(t9).size(150,150).noStroke().fill(#FF3300).loc(440, 440);


	HGroup grp = (HGroup) H.add(new HGroup());

	grp.add(new HText("Isoceles"))   .noStroke().fill(#CCCCCC).loc(50,20);
	grp.add(new HText("Right"))      .noStroke().fill(#CCCCCC).loc(50,215);
	grp.add(new HText("Equilateral")).noStroke().fill(#CCCCCC).loc(50,410);


	H.drawStage();

	noLoop();
}

void draw() {}