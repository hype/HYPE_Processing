import hype.*;

HImage img1, img2, img3;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#FF3300).use3D(true);

	img1 = new HImage("tex1.png");
	img2 = new HImage("tex2.png");
	img3 = new HImage("tex3.png");

	H.add(new HSprite(200,200).texture(img1)).loc(10,  10);
	H.add(new HSprite(410,200).texture(img1)).loc(220, 10);

	H.add(new HSprite(200,360).texture(img2)).loc(10, 220);
	H.add(new HSprite(150,150).texture(img2)).loc(220,220);
	H.add(new HSprite(110,110).texture(img2)).loc(380,220);
	H.add(new HSprite(80,80)  .texture(img2)).loc(500,220);
	H.add(new HSprite(40,40)  .texture(img2)).loc(590,220);

	H.add(new HSprite(200,40) .texture(img3)).loc(10, 590);
	H.add(new HSprite(150,250).texture(img3)).loc(220,380);
	H.add(new HSprite(110,290).texture(img3)).loc(380,340);
	H.add(new HSprite(80,320) .texture(img3)).loc(500,310);
	H.add(new HSprite(40,360) .texture(img3)).loc(590,270);
}

void draw() {
	H.drawStage();
}
