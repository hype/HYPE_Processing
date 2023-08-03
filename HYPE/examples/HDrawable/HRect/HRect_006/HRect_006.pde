import hype.*;
import hype.extended.behavior.HRotate;

int     stageW = 900;
int     stageH = 900;
int     w, h, m;
color   clrBg  = #242424;

// **************************************************

HRect   s1, s2, s3;
HRotate r1, r2, r3;

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
	s1 = new HRect(100);
	s1.rounding(5).noStroke().fill(#FF3300).loc(0,0);

	r2 = new HRotate().speed(1.0);
	s2 = new HRect(100);
	s2.rounding(5).noStroke().fill(#FF6600).anchorAt(H.CENTER).loc(0,0);

	r3 = new HRotate().speed(1.0);
	s3 = new HRect(100);
	s3.rounding(5).noStroke().fill(#FF9900).anchor(50, 25).loc(0,0);
}

void draw() {
	background(clrBg);
	visualizeHelper();

	r1.run();
	push();
		translate( w-m, h );
		rotate( r1.curRad() );
		s1.draw(this.g);
	pop();

	r2.run();
	push();
		translate( w, h );
		rotate( r2.curRad() );
		s2.draw(this.g);
	pop();

	r3.run();
	push();
		translate( w+m, h );
		rotate( r3.curRad() );
		s3.draw(this.g);
	pop();
}

// **************************************************

void visualizeHelper() {
	
// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);

	ellipse( w-m, h, 6, 6);
	ellipse( w,     h, 6, 6);
	ellipse( w+m, h, 6, 6);

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
