import hype.*;

int   stageW = 800;
int   stageH = 800;
color clrBg  = #242424;

// **************************************************

HRect s1, s2;

void settings() {
	size(stageW, stageH, P3D);
}

void setup() {
	H.init(this);
	background(clrBg);

	int _w = width/2;
	int _h = height/2;
	int _m = 200; // margin

	s1 = new HRect();
	s1.rounding(10).strokeWeight(3).stroke(#FF3300).fill(#ECECEC).anchorAt(H.CENTER).size(100).loc(_w-_m, _h);

	s2 = s1.createCopy(); // copy all properties from s1
	s2.loc(_w+_m, _h);    // change the location / override the loc() method copied from s1
}

void draw() {
	background(clrBg);
	visualizeHelper();

	s1.draw(this.g);
	s2.draw(this.g);
}

// **************************************************

void visualizeHelper() {
	hint(DISABLE_DEPTH_TEST);

// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);

	ellipse(s1.x(), s1.y(), 6, 6);
	ellipse(s2.x(), s2.y(), 6, 6);

// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, height/2, width, height/2);
	line(width/2, 0, width/2, height);
}
