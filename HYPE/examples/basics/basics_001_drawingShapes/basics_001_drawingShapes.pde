import hype.*;

int   stageW = 640;
int   stageH = 640;
color clrBg  = #242424;

// **************************************************

HRect s1, s2, s3, s4;     // ROW 1
HRect s5, s6, s7, s8;     // ROW 2
HRect s9, s10, s11, s12;  // ROW 3
HRect s13, s14, s15, s16; // ROW 4

void settings() {
	size(stageW, stageH, P3D);
}

void setup() {
	H.init(this);
	background(clrBg);

// ************************************************** ROW 1

	s1 = new HRect();
	s1.noStroke().fill(#ECECEC).loc(50,50);

	s2 = new HRect();
	s2.rounding(10).noStroke().fill(#ECECEC).loc(200,50);

	s3 = new HRect();
	s3.rounding(10).noStroke().fill(#ECECEC).anchorAt(H.CENTER).rotation(45).loc(400,100);

	s4 = new HRect();
	s4.rounding(10).noStroke().fill(236).loc(500,50);

// ************************************************** ROW 2

}

void draw() {
	background(clrBg);

	s1.draw(this.g);
	s2.draw(this.g);
	s3.draw(this.g);
	s4.draw(this.g);

}
