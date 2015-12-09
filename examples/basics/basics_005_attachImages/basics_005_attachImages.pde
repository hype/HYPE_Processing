import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#00616f);

	HImage img1 = new HImage("img1.jpg");
	H.add(img1)
		.anchorAt(H.BOTTOM|H.RIGHT)
		.loc(width-10,height-10);
	;

	HImage img2 = new HImage("img2.jpg");
	H.add(img2)
		.alpha(225)
		.rotation(6)
		.loc(50,20)
	;

	HImage img3 = new HImage("img3.jpg");
	H.add(img3)
		.scale(0.7f)
		.rotation(6)
		.loc(50,280)
	;

	H.drawStage();
	noLoop();
}

void draw() {

}
