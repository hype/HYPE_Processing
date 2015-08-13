import processing.video.*;

Movie tex;
PVector[] pickedPos;
int[]     pickedScale;
int numAssets = 25;

void setup() {
	size(640, 640, P3D);

	tex = new Movie(this, "movie.mp4");
	tex.loop();

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
			translate(pt.x, pt.y, pt.z);
			rotateX( radians(-(frameCount)) );
			rotateY( radians(frameCount) );
			scale( pickedScale[i] );

			TexturedCube();
		popMatrix();
	}
}

void TexturedCube() {
	beginShape(QUADS);
		texture(tex);

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

void movieEvent(Movie m) {
  m.read();
}


