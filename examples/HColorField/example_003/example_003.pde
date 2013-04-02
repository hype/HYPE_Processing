HFollow mf;
HRect rect;
HColorField colorField;
HOscillator soBase;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();
	
	colorField = new HColorField(width, height)
	    .addPoint(0, height/2, #FF0066, 0.5f)
	    .addPoint(width, height/2, #3300FF, 0.5f)
	    .fillOnly()
	    // .strokeOnly()
	    // .fillAndStroke()
    ;

    soBase = new HOscillator().speed(1f).range(10,100).freq(4f).property(H.SIZE);

	rect = new HRect(100);
	rect.rounding(40)
		.fill(#000000)
		.strokeWeight(2)
		.stroke(#000000, 150)
		.loc(width/2,height/2)
		.anchorAt(H.CENTER)
		.rotation(45);
	H.add(rect);

	// HFollow / spring
	mf = new HFollow()
		.target(rect)
		.ease(0.05)
		.spring(0.95)
    ;

	HOscillator so = soBase.createCopy();
	so.target( rect );

}

void draw() {
	rect.anchorAt(H.CENTER);
	rect.fill(#000000);
	colorField.applyColor(rect);

	H.drawStage();
}