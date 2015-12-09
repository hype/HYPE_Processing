import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HPath p1 = new HPath();
	p1
		.vertex(50,50)
		.vertex(200,50)
		.vertex(200,200)
		.vertex(50,200)
	;
	p1.fill(#242424).strokeWeight(4).stroke(#FF9900);
	H.add(p1);

	HPath p2 = new HPath();
	p2
		.vertex(245,50)
		.vertex(395,50)
		.vertex(245,200)
		.vertex(395,200)
	;
	p2.fill(#242424).strokeWeight(4).stroke(#FF6600);
	H.add(p2);

	HPath p3 = new HPath();
	p3
		.vertex(440,50)
		.vertex(515,75)
		.vertex(590,50)
		.vertex(565,125)
		.vertex(590,200)
		.vertex(515,175)
		.vertex(440,200)
		.vertex(465,125)
	;
	p3.fill(#242424).strokeWeight(4).stroke(#FF3300);
	H.add(p3);



	HPath p4 = new HPath(POLYGON);
	p4
		.vertex(50,245)
		.vertex(200,245)
		.vertex(200,395)
		.vertex(50,395)
	;
	p4.fill(#242424).strokeWeight(4).stroke(#FF9900);
	H.add(p4);

	HPath p5 = new HPath(POLYGON);
	p5
		.vertex(245,245)
		.vertex(395,245)
		.vertex(245,395)
		.vertex(395,395)
	;
	p5.fill(#242424).strokeWeight(4).stroke(#FF6600);
	H.add(p5);

	HPath p6 = new HPath(POLYGON);
	p6
		.vertex(440,245)
		.vertex(515,270)
		.vertex(590,245)
		.vertex(565,320)
		.vertex(590,395)
		.vertex(515,370)
		.vertex(440,395)
		.vertex(465,320)
	;
	p6.fill(#242424).strokeWeight(4).stroke(#FF3300);
	H.add(p6);



	int x1 = 50; int x2 = 200; int y1 = 440; int y2 = 590;

	HPath p7 = new HPath(POLYGON);
	p7
		.vertex(x1+50,y1+50, x1-50,y1-50, x1,y1)
		.vertex(x2-50,y1+50, x2+50,y1-50, x2,y1)
		.vertex(x2-50,y2-50, x2+50,y2+50, x2,y2)
		.vertex(x1+50,y2-50, x1-50,y2+50, x1,y2)
	;
	p7.fill(#242424).strokeWeight(4).stroke(#999999);
	H.add(p7);

	HPath p8 = new HPath(POLYGON).mode(POINTS);
	p8
		.vertex(245,440)
		.vertex(395,440)
		.vertex(245,590)
		.vertex(395,590)
	;
	p8.fill(#242424).strokeWeight(4).stroke(#CCCCCC);
	H.add(p8);

	HPath p9 = new HPath(POLYGON).mode(POINTS);
	p9
		.vertex(440,440)
		.vertex(515,465)
		.vertex(590,440)
		.vertex(565,515)
		.vertex(590,590)
		.vertex(515,565)
		.vertex(440,590)
		.vertex(465,515)
	;
	p9.fill(#242424).strokeWeight(4).stroke(#FFFFFF);
	H.add(p9);

	H.drawStage();
	noLoop();
}

void draw() {

}
