HFollow mf;
HRect d;
HColorField colorField;

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

	d = new HRect(100);
	d
		.rounding(40)
		.fill(#000000)
		.strokeWeight(2)
		.stroke(#000000, 150)
		.loc(width/2,height/2)
		.anchorAt(H.CENTER)
		.rotation(45)
	;
	H.add(d);

	mf = new HFollow()
		.target(d)
		.ease(0.05)
		.spring(0.95)
	;

	new HOscillator()
		.target(d)
		.property(H.SIZE)
		.range(10, 100)
		.speed(1)
		.freq(4)
	;
}

void draw() {
	d.anchorAt(H.CENTER);
	d.fill(#000000);
	colorField.applyColor(d);

	H.drawStage();
}

