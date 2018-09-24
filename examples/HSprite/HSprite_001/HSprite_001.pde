import hype.*;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( new HSprite().texture("tex1.jpg") )
		.size(200)
		.anchorAt(H.CENTER)
		.loc(width/2, height/2)
	;
}

void draw() {
	H.drawStage();
}
