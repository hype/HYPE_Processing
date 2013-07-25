HFollow mf;
HRect d;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	d = new HRect(100);
	d
		.rounding(40)
		.noStroke()
		.fill(#ECECEC)
		.loc(width/2,height/2)
		.anchorAt(H.CENTER)
		.rotation(45)
	;
	H.add(d);

	// HFollow / ease and spring

	mf = new HFollow()
		.target(d)
		.ease(0.1)
		.spring(0.95)
	;
}

void draw() {
	H.drawStage();
}

