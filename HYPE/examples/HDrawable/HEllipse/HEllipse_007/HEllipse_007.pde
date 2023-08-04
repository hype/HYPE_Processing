import hype.*;
import hype.extended.behavior.HRotate;

int       stageW = 900;
int       stageH = 900;
int       w, h, m;
color     clrBg  = #242424;

// **************************************************

HRotate   r1;

HEllipse  s1;
int       s1Radius = 100;

int       numAssets = 1000;
PVector[] pos = new PVector[numAssets];

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;
	m = 225;

	r1 = new HRotate().speed(1.0);

	s1 = new HEllipse(s1Radius);
	s1.noStroke().fill(#ECECEC).anchor(s1Radius, 325).loc(w, h);

	for (int i=0; i<numAssets; ++i) {
		pos[i] = new PVector(
			random(0, stageW), // x
			random(0, stageH), // y
			0                  // z
		);
	}
}

void draw() {
	background(clrBg);
	visualizeHelper();

	r1.run();
	s1.rotation( r1.cur() ).draw(this.g);

	for (int i=0; i<numAssets; ++i) {
		push();
			translate(pos[i].x, pos[i].y, pos[i].z);
			strokeWeight(0);
			noStroke();

			if( s1.contains(pos[i].x, pos[i].y ) ) { // check if x,y is inside the s1 ellipse
				fill(#FF9900);
				ellipse(0, 0, 20, 20);
			} else {
				fill(#FF3300);
				ellipse(0, 0, 6, 6);
			}
		pop();
	}
}

// **************************************************

void visualizeHelper() {
	
// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);

	ellipse( s1.x(), s1.y(), 6, 6);

// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, height/2, width, height/2);
	line(width/2, 0, width/2, height);

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}


