void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	HShape svg1 = new HShape("cog_sm.svg");
	H.add(svg1)
		.enableStyle(false)
		.anchorAt(H.CENTER)
		.loc(223,413)
		.fill(#FF3300)
	;

	new HRotate(svg1, -0.5);

	HShape svg2 = new HShape("cog_lg.svg");
	H.add(svg2)
		.enableStyle(false)
		.anchorAt(H.CENTER)
		.loc(690,260)
		.fill(#FF6600)
	;

	new HRotate(svg2, 0.3333 );
}

void draw() {
	H.drawStage();
}

