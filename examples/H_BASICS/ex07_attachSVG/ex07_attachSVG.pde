HColorPool colors;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	// all Fills = 1 color / all Strokes = 1 color

	HShape svg1 = new HShape("bot1.svg");
	svg1
		.enableStyle(false)
		.loc(25,25)
		.anchorAt(H.TOP|H.LEFT)
		.fill(#181818)
		.stroke(#0095a8)
		.strokeWeight(2)
	;
	H.add(svg1);

	// random Fills AND Strokes being pulled from HColorPool colors

	HShape svg2 = new HShape("bot1.svg");
	svg2
		.loc(width-25,25)
		.anchorAt(H.TOP|H.RIGHT)
		.strokeWeight(2)
	;
	svg2.randomColors(colors.fillAndStroke());
	H.add(svg2);

	// random Fills being pulled from HColorPool colors / all Strokes = 1 color

	HShape svg3 = new HShape("bot1.svg");
	svg3
		.loc(25,height-25)
		.anchorAt(H.BOTTOM|H.LEFT)
		.stroke(#000000)
		.strokeWeight(2)
	;
	svg3.randomColors(colors.fillOnly());
	H.add(svg3);

	// random Strokes being pulled from HColorPool colors / all Fills = 1 color

	HShape svg4 = new HShape("bot1.svg");
	svg4
		.loc(width-25,height-25)
		.anchorAt(H.BOTTOM|H.RIGHT)
		.fill(#181818)
		.strokeWeight(2)
	;
	svg4.randomColors(colors.strokeOnly());
	H.add(svg4);

	H.drawStage();
	noLoop();
}

void draw() {}

