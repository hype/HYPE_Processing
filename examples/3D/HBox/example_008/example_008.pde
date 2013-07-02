import processing.opengl.*;
PImage texImg;
PVector[] pickedPos;
int[]     pickedScale;
int numAssets = 25;

void setup() {
	size(640, 640, OPENGL);
	texImg = loadImage("lines.jpg");
	textureMode(NORMAL);

	pickedPos = new PVector[numAssets];
	pickedScale = new int[numAssets];

	for (int i = 0; i<numAssets; i++){
	    PVector pt = new PVector();
	    pt.x = (int)random(width);
	    pt.y = (int)random(height);
	    pt.z = (int)random(-100,100);
	    pickedPos[i] = pt;

	    pickedScale[i] = (int)random(50,125);
	}
}

void draw() {
	background(0); noStroke(); noFill();

	for (int i = 0; i<numAssets; i++){
		PVector pt = pickedPos[i];
		pushMatrix();
			// translate(pt.x, pt.y, pt.z);
			translate(pt.x, pt.y, 0);
			rotateX( radians(-(frameCount)) );
			rotateY( radians(frameCount) );
			scale( pickedScale[i] );

			TexturedCube(texImg);
		popMatrix();
	}


}

void TexturedCube(PImage texImg) {
	beginShape(QUADS);
		texture(texImg);

		// +Z "front" face
		vertex(-1, -1,  1, 0, 0);
		vertex( 1, -1,  1, 1, 0);
		vertex( 1,  1,  1, 1, 1);
		vertex(-1,  1,  1, 0, 1);

		// -Z "back" face
		vertex( 1, -1, -1, 0, 0);
		vertex(-1, -1, -1, 1, 0);
		vertex(-1,  1, -1, 1, 1);
		vertex( 1,  1, -1, 0, 1);

		// +Y "bottom" face
		vertex(-1,  1,  1, 0, 0);
		vertex( 1,  1,  1, 1, 0);
		vertex( 1,  1, -1, 1, 1);
		vertex(-1,  1, -1, 0, 1);

		// -Y "top" face
		vertex(-1, -1, -1, 0, 0);
		vertex( 1, -1, -1, 1, 0);
		vertex( 1, -1,  1, 1, 1);
		vertex(-1, -1,  1, 0, 1);

		// +X "right" face
		vertex( 1, -1,  1, 0, 0);
		vertex( 1, -1, -1, 1, 0);
		vertex( 1,  1, -1, 1, 1);
		vertex( 1,  1,  1, 0, 1);

		// -X "left" face
		vertex(-1, -1, -1, 0, 0);
		vertex(-1, -1,  1, 1, 0);
		vertex(-1,  1,  1, 1, 1);
		vertex(-1,  1, -1, 0, 1);

	endShape();
}
