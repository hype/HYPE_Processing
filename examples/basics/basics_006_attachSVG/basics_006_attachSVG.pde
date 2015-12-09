import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	// enableStyle = true / keep SVG base styling / DEFAULT

	HShape svg1 = new HShape("bot1.svg");
	svg1
		.anchorAt(H.LEFT | H.CENTER_Y)
		.loc(25,height/2)
	;
	H.add(svg1);

	// enableStyle = false / destroy SVG base styling and override

	HShape svg2 = new HShape("bot1.svg");
	svg2
		.enableStyle(false)
		.strokeWeight(2)
		.stroke(#ED1B6A)
		.fill(#181818)
		.anchorAt(H.RIGHT | H.CENTER_Y)
		.loc(width-25,height/2)
	;
	H.add(svg2);

	H.drawStage();
	noLoop();
}

void draw() {

}
