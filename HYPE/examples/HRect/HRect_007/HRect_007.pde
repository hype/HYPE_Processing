import hype.*;
import hype.extended.behavior.HRotate;

int     stageW = 900;
int     stageH = 900;
int     w, h, m;
color   clrBg  = #242424;

// **************************************************

HRect   d1;
HRotate r1;

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
	m = 225;

	r1 = new HRotate().speedX(0.4).speedY(0.6).speedZ(0.8);
	d1 = new HRect(300);
	d1.rounding(20).noStroke().fill(#FF3300).anchorAt(H.CENTER).loc(0,0);
}

void draw() {
	background(clrBg);
	visualizeHelper();

	r1.run();
	push();
		translate( w, h );
		// rotateX( r1.curXRad() );
		// rotateY( r1.curYRad() );
		// rotateZ( r1.curZRad() );
		d1.rotationX(r1.curX()).rotationY(r1.curY()).rotationZ(r1.curZ());
		d1.draw(this.g);
	pop();
}

// **************************************************

void visualizeHelper() {
	
	// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);

	ellipse( w, h, 6, 6);

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
