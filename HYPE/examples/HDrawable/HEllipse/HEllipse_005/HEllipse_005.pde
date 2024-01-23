import hype.*;
import hype.extended.behavior.HOscillator;

int         stageW = 900;
int         stageH = 900;
int         w, h, m;
color       clrBg  = #242424;

// **************************************************

HEllipse    d1, d2, d3;
HOscillator o1, o2, o3;

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

	o1 = new HOscillator().range(0,180).speed(1);
	d1 = new HEllipse(60);
	d1.noStroke().fill(#FF3300).anchorAt(H.CENTER).loc(w-m, h);

	o2 = new HOscillator().range(1,360).speed(1);
	d2 = new HEllipse(60);
	d2.noStroke().fill(#FF6600).anchorAt(H.CENTER).loc(w, h);

	o3 = new HOscillator().range(0,0, 45,-45).speed(1).freq(5); // range = minA minB maxA maxB / cur1(minA,maxA) / cur2(minB,maxB)
	d3 = new HEllipse(60);
	d3.noStroke().fill(#FF9900).anchorAt(H.CENTER).loc(w+m, h);
}

void draw() {
	background(clrBg);
	visualizeHelper();

	o1.run();
	d1.start( o1.cur() ).draw(this.g);

	o2.run();
	d2.end( o2.cur() ).draw(this.g);

	o3.run();
	d3.start( o3.cur1() ).end( o3.cur2() ).draw(this.g);
}

// **************************************************

void visualizeHelper() {
	
// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);

	ellipse( d1.x(), d1.y(), 6, 6);
	ellipse( d2.x(), d2.y(), 6, 6);
	ellipse( d3.x(), d3.y(), 6, 6);

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
