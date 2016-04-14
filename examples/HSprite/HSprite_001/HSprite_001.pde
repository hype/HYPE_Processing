import hype.*;

HImage  i1;
HSprite s1;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	i1 = new HImage("tex1.jpg");

	s1 = new HSprite(i1.width(), i1.height());
	s1
		.texture(i1.image())
		.loc(width/2, height/2)
		.anchorAt(H.CENTER)
	;
	H.add(s1);
}

void draw() {
	H.drawStage();
}
