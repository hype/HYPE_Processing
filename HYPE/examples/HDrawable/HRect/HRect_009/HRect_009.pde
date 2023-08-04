import hype.*;
import hype.extended.behavior.HRotate;

int     stageW = 900;
int     stageH = 900;
int     w, h, m;
color   clrBg  = #242424;

// **************************************************

HCanvas canvas;
HRect   s1, s2, s3, s4;
HGroup  grp;
HRotate r1;

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;
	m = 100;

	canvas = new HCanvas(P3D).autoClear(false).fade(3);

	r1 = new HRotate().speed(1.0);

	s1 = new HRect(100);
	s1.rounding(20).strokeWeight(0).noStroke().fill(#FF3300).anchorAt(H.CENTER).loc(-m,-m);

	s2 = (HRect) s1.createCopy().fill(#FF6600).loc(m,-m);
	s3 = (HRect) s1.createCopy().fill(#FF9900).loc(-m,m);
	s4 = (HRect) s1.createCopy().fill(#FFCC00).loc(m,m);

	grp = new HGroup();
	grp.noStroke();
	grp.add(s1);
	grp.add(s2);
	grp.add(s3);
	grp.add(s4);
	grp.loc(w, h);

	canvas.add(grp);
}

void draw() {
	background(clrBg);
	visualizeHelper();

	r1.run();

	grp.rotation( r1.cur() );
	canvas.draw(this.g);
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
	line(0, height/2, width, height/2);
	line(width/2, 0, width/2, height);

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
