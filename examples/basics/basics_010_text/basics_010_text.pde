import hype.*;

PFont font1, font2, font3, font4;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	font1 = createFont("DroidSerifRegular.ttf", 18);
	font2 = createFont("DroidSerifItalic.ttf", 48);
	font3 = createFont("DroidSerifBold.ttf", 48);
	font4 = createFont("DroidSerifBoldItalic.ttf", 48);

	HText f1 = new HText("T / L",48,font2);
	f1.fill(#FFFFFF).anchorAt(H.CENTER).loc(100,100);
	H.add(f1);

	HText f2 = new HText("T / C",48,font2);
	f2.fill(#FFFFFF).anchorAt(H.CENTER).loc(width/2,100);
	H.add(f2);

	HText f3 = new HText("T / R",48,font2);
	f3.fill(#FFFFFF).anchorAt(H.CENTER).loc(width-100,100);
	H.add(f3);


	HText f4 = new HText("C / L",48,font3);
	f4.fill(#CCCCCC).anchorAt(H.CENTER).loc(100,height/2);
	H.add(f4);

	HText f5 = new HText("C / C",48,font3);
	f5.fill(#CCCCCC).anchorAt(H.CENTER).loc(width/2,height/2);
	H.add(f5);

	HText f6 = new HText("C / R",48,font3);
	f6.fill(#CCCCCC).anchorAt(H.CENTER).loc(width-100,height/2);
	H.add(f6);


	HText f7 = new HText("B / L",48,font4);
	f7.fill(#999999).anchorAt(H.CENTER).loc(100,height-100);
	H.add(f7);

	HText f8 = new HText("B / C",48,font4);
	f8.fill(#999999).anchorAt(H.CENTER).loc(width/2,height-100);
	H.add(f8);

	HText f9 = new HText("B / R",48,font4);
	f9.fill(#999999).anchorAt(H.CENTER).loc(width-100,height-100);
	H.add(f9);


	HText d1 = new HText("working with type / DroidSerif-Regular.ttf / 18pt",18,font1);
	d1.fill(#0095a8).loc(50,30);
	H.add(d1);

	HText d2 = new HText("DroidSerif-Italic.ttf / 48pt",18,font2);
	d2.fill(#FF3300).loc(50,140);
	H.add(d2);

	HText d3 = new HText("DroidSerif-Bold.ttf / 48pt",18,font3);
	d3.fill(#FF6600).loc(50,height/2+40);
	H.add(d3);

	HText d4 = new HText("DroidSerif-BoldItalic.ttf / 48pt",18,font4);
	d4.fill(#FF9900).loc(50,height-60);
	H.add(d4);


	H.drawStage();
	noLoop();
}

void draw() {

}
