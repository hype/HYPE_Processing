import hype.*;

HIcosahedron icos;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( icos = new HIcosahedron() )
		.stroke(0)
		.fill(255)
		.size(200)
		.loc(width/2, height/2)
	;
}

void draw() {
	lights();
	icos.rotationY(mouseX);
	H.drawStage();	
}
