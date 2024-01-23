import hype.*;
import hype.extended.behavior.HRotate;

int     stageW = 900;
int     stageH = 900;
int     w, h, m;
color   clrBg  = #242424;

// **************************************************

HCanvas canvas;
HRect   d1, d2, d3, d4;
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

	d1 = new HRect(100);
	d1.rounding(20).strokeWeight(0).noStroke().fill(#FF3300).anchorAt(H.CENTER).loc(-m,-m);

	d2 = (HRect) d1.createCopy().fill(#FF6600).loc(m,-m);
	d3 = (HRect) d1.createCopy().fill(#FF9900).loc(-m,m);
	d4 = (HRect) d1.createCopy().fill(#FFCC00).loc(m,m);

	grp = new HGroup();
	grp.noStroke();
	grp.add(d1);
	grp.add(d2);
	grp.add(d3);
	grp.add(d4);
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
