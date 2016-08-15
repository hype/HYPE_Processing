import hype.*;

void setup() {
	size(640,640,P3D);

	H.init(this).background(#242424).use3D(true);

	HIcosahedron icos = new HIcosahedron();
	icos.x(width/2).y(height/2);
	H.add(icos);

	lights();
	H.drawStage();
	noLoop();

}

void draw() {
	
}

