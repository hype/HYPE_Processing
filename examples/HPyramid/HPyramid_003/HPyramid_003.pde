import hype.*;

HPyramid pyr;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( pyr = new HPyramid().sides(8).topRadius(50) )
		.stroke(0)
		.fill(255)
		.size(200)
		.loc(width/2, height/2)
		.rotationX(-20)
	;
}

void draw() {
	lights();
	pyr.rotationY(mouseX);
	H.drawStage();  
}
