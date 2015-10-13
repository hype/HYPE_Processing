HImage i1;
HSprite s1, s2, s3;

void setup() {
	size(800,640, OPENGL);
	H.init(this).background(#202020);
	smooth();

	frameRate(60);

	i1 = new HImage("hex.png");

	s1 = new HSprite(i1.width(), i1.height()).texture(i1.image());
	s2 = new HSprite(i1.width()/2, i1.height()/2).texture(i1.image());
	s3 = new HSprite(i1.width()/4, i1.height()/4).texture(i1.image());

	//position the sprites
	s1.loc(250, 320).anchorAt(H.CENTER);
	s2.loc(550, 320).anchorAt(H.CENTER);
	s3.loc(700, 320).anchorAt(H.CENTER);

	H.add(s1);
	H.add(s2);
	H.add(s3);

}

void draw() {
	H.drawStage();
}
