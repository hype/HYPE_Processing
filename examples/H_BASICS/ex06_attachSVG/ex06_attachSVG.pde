void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	// disableStyle = false / keep SVG base styling / DEFAULT

	HShape svg1 = new HShape("bot1.svg");
	svg1
		.loc(25,height/2)
		.anchorAt(H.LEFT | H.CENTER_Y)
	;
	H.add(svg1);

	// disableStyle = true / destroy SVG base styling and override

	HShape svg2 = new HShape("bot1.svg");
	svg2
		.enableStyle(false)
		.loc(width-25,height/2)
		.anchorAt(H.RIGHT | H.CENTER_Y)
		.fill(#181818)
		.stroke(#ED1B6A)
		.strokeWeight(2)
	;
	H.add(svg2);

	H.drawStage();
	noLoop();
}

void draw() {}

