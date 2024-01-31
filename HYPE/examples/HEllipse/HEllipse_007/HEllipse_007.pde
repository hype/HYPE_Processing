import hype.*;
import hype.extended.behavior.HRotate;

int       stageW = 900;
int       stageH = 900;
int       w, h, m;
color     clrBg  = #242424;

// **************************************************

HRotate   r1;

HEllipse  d1;
int       d1Radius = 100;

int       numAssets = 1000;
PVector[] pos = new PVector[numAssets];

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = stageW/2;
	h = stageH/2;
	m = stageW/4;

	r1 = new HRotate().speed(1.0);

	d1 = new HEllipse(d1Radius);
	d1.noStroke().fill(#ECECEC).anchor(d1Radius, 325).loc(w, h);

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
	d1.rotation( r1.cur() ).draw(this.g);

	for (int i=0; i<numAssets; ++i) {
		push();
			translate(pos[i].x, pos[i].y, pos[i].z);
			strokeWeight(0);
			noStroke();

			if( d1.contains(pos[i].x, pos[i].y ) ) { // check if x,y is inside the d1 ellipse
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

	ellipse( d1.x(), d1.y(), 6, 6);

	// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, stageH/2, stageW, stageH/2);
	line(stageW/2, 0, stageW/2, stageH);

	// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}


