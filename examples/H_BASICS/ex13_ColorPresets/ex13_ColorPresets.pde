void setup() {
	size(640,640);
	H.init(this).background(#242424);
	smooth();

	/*
	 * The color presets are just
	 * simple int constants located
	 * in the HConstants interface.
	 *
	 * (Note: since `H` and `HMath`
	 * implements HConstants, you can
	 * access the presets via said
	 * classes.)
	 */

	HGridLayout grid = new HGridLayout(3).spacing(210,157).startLoc(10,10);

	int[] clrs = {
		H.CLEAR, // This is equal to transparent white (0x00FFFFFF)
		H.WHITE, H.BLACK,
		H.LGREY, H.GREY, H.DGREY, 
		H.RED, H.GREEN, H.BLUE,
		H.CYAN, H.YELLOW, H.MAGENTA
	};

	for(int i=0; i<clrs.length; i++) {
		H.add(new HRect(200,147))
			.loc( grid.getNextPoint() )
			.stroke(H.BLACK, 150)
			.strokeWeight(3)
			.fill(clrs[i])
		;
	}

	H.drawStage();
	noLoop();
}

void draw() {}

