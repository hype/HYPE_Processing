HColorPool colors;
HFollow mf;
HRect d;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	d = new HRect(100);
	d
		.rounding(40)
		.fill(#111111)
		.strokeWeight(2)
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
}

void draw() {
	d.stroke( colors.getColor() );

	H.drawStage();
}

