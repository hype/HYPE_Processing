HCanvas canvas;

final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #ff3300, #ff3300, #242424, #333333, #666666);

HOscillator roBase;

void setup() {
	size(640,640);
	H.init(this).background(#111111);
	// smooth();

	canvas = new HCanvas().autoClear(true);
	H.add(canvas);

    roBase = new HOscillator().speed(0.4).range(-20,20).freq(8).property(H.ROTATION).waveform(H.SINE);

	int starScale = 800;
	int starOffest = 15;

	for (int i = 0; i<53; i++){
		HPath star1 = new HPath();
		star1
			.star( 5, 0.5, -90 )
			.size(starScale)
			// .strokeWeight(1)
			// .stroke(#000000, 50)
			.noStroke()
			.fill( colors.getColor(i*250), 255 )
			.anchorAt(H.CENTER)
			// .anchor( H.CENTER_X ,50)
			.loc(width/2,height/2)
		;
		canvas.add(star1);

		HOscillator ro = roBase.createCopy();
		ro.target( star1 ).currentStep( i );

		starScale -= starOffest;
	}


}

void draw() {
	H.drawStage();
}

