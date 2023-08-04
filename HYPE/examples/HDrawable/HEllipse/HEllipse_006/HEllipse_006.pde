import hype.*;
import hype.extended.behavior.HOscillator;

int         stageW = 900;
int         stageH = 900;
int         w, h, m;
color       clrBg  = #242424;

// **************************************************

HCanvas     canvas;

HEllipse    s1, s2;
HOscillator o1, o2;

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

	canvas = new HCanvas(P3D).autoClear(false).fade(5);

	o1 = new HOscillator().range(1,360).speed(1);
	s1 = new HEllipse(300);
	s1.noStroke().fill(#FF3300).anchorAt(H.CENTER).loc(w, h);

	o2 = new HOscillator().range(0,0, 179,-179).speed(1).freq(1);
	s2 = new HEllipse(150);
	s2.noStroke().fill(#FF6600).anchorAt(H.CENTER).loc(w, h);

	canvas.add(s1);
	canvas.add(s2);
}

void draw() {
	background(clrBg);
	visualizeHelper();

	o1.run();
	s1.end( o1.cur() );

	o2.run();
	s2.start( o2.cur1() ).end( o2.cur2() );

	canvas.draw(this.g);
}

// **************************************************

void visualizeHelper() {
	
// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);

	ellipse( s1.x(), s1.y(), 6, 6);
	ellipse( s2.x(), s2.y(), 6, 6);

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
