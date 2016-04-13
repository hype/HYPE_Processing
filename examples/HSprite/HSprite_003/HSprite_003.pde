import hype.*;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#FF3300).use3D(true);

	H.add(new HSprite(200,200).texture(new HImage("tex1.png"))).loc(10,  10);
	H.add(new HSprite(410,200).texture(new HImage("tex1.png"))).loc(220, 10);

	H.add(new HSprite(200,360).texture(new HImage("tex2.png"))).loc(10, 220);
	H.add(new HSprite(150,150).texture(new HImage("tex2.png"))).loc(220,220);
	H.add(new HSprite(110,110).texture(new HImage("tex2.png"))).loc(380,220);
	H.add(new HSprite(80,80)  .texture(new HImage("tex2.png"))).loc(500,220);
	H.add(new HSprite(40,40)  .texture(new HImage("tex2.png"))).loc(590,220);

	H.add(new HSprite(200,40) .texture(new HImage("tex3.png"))).loc(10, 590);
	H.add(new HSprite(150,250).texture(new HImage("tex3.png"))).loc(220,380);
	H.add(new HSprite(110,290).texture(new HImage("tex3.png"))).loc(380,340);
	H.add(new HSprite(80,320) .texture(new HImage("tex3.png"))).loc(500,310);
	H.add(new HSprite(40,360) .texture(new HImage("tex3.png"))).loc(590,270);
}

void draw() {
	H.drawStage();
}
