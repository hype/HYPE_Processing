HCanvas canvas;
HOscillator roBase;

color[]palette = {#333333, #666666, #999999, #CCCCCC, #F7F7F7};

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	canvas = new HCanvas().autoClear(true);
	H.add(canvas);

    roBase = new HOscillator().speed(0.2).range(-20,20).freq(8).property(H.ROTATION).waveform(H.SINE);

	int starScale = 200;
	int starOffest = 40;

	for (int i = 0; i<9; i++){
		for (int j = 0; j<5; j++){

			int row = (int) Math.floor(i / 3);
			int col = i % 3;

			int ranEdges = round(random(5, 10));
			float ranDepth = random(0.25, 0.75);

			HPath poly = new HPath();
			poly
				.star( ranEdges, ranDepth )
				.size(starScale)
				.noStroke()
				.fill( palette[j] )
				.anchorAt(H.CENTER)
				.loc(col*200+120, row*200+120)
			;
			canvas.add(poly);

			HOscillator ro = roBase.createCopy();
			ro.target( poly ).currentStep( j );

			starScale -= starOffest;
		}
		starScale = 200;		
	}
}

void draw() {
	H.drawStage();
}
