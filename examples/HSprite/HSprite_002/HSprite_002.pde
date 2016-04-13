import hype.*;

HImage  jpg1, jpg2, jpg3;
HImage  png1, png2, png3;

HSprite s1, s2, s3, s4, s5, s6;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#FF3300).use3D(true);

	jpg1 = new HImage("tex1.jpg");
	jpg2 = new HImage("tex2.jpg");
	jpg3 = new HImage("tex3.jpg");

	png1 = new HImage("tex1.png");
	png2 = new HImage("tex2.png");
	png3 = new HImage("tex3.png");

	H.add(s1 = new HSprite(jpg1.width(), jpg1.height()).texture(jpg1.image())).loc((width/2)-210, height/3).anchorAt(H.CENTER);
	H.add(s2 = new HSprite(jpg2.width(), jpg2.height()).texture(jpg2.image())).loc(width/2, height/3).anchorAt(H.CENTER);
	H.add(s3 = new HSprite(jpg3.width(), jpg3.height()).texture(jpg3.image())).loc((width/2)+210, height/3).anchorAt(H.CENTER);

	// PNG being the ideal texture to map to HSprite / nothing but transparency love

	H.add(s4 = new HSprite(png1.width(), png1.height()).texture(png1.image())).loc((width/2)-210, height/1.5).anchorAt(H.CENTER);
	H.add(s5 = new HSprite(png2.width(), png2.height()).texture(png2.image())).loc(width/2, height/1.5).anchorAt(H.CENTER);
	H.add(s6 = new HSprite(png3.width(), png3.height()).texture(png3.image())).loc((width/2)+210, height/1.5).anchorAt(H.CENTER);
}

void draw() {
	H.drawStage();
}
