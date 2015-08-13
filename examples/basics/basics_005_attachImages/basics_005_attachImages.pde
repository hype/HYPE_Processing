import hype.*;

PImage pi01, pi02, pi03;

void setup() {
	size(640,640);
	H.init(this).background(#00616f);

	pi01 = loadImage("img01.jpg");
	pi02 = loadImage("img02.jpg");
	pi03 = loadImage("img03.jpg");

	HImage img01 = new HImage(pi01);
	H.add(img01)
		.anchorAt(H.BOTTOM|H.RIGHT)
		.loc(width-10,height-10);
	;

	HImage img02 = new HImage(pi02);
	H.add(img02)
		.loc(50,20)
		.rotation(6)
		.alpha(225)
	;

	HImage img03 = new HImage(pi03);
	H.add(img03)
		.loc(50,280)
		.scale(0.7f)
		.rotation(6)
	;

	H.drawStage();
	noLoop();
}

void draw() {}

