import hype.*;

int   stageW = 800;
int   stageH = 800;
color clrBg  = #242424;

// **************************************************

HRect s1, s2, s3;
HRect s4, s5, s6;
HRect s7, s8, s9;

void settings() {
	size(stageW, stageH, P3D);
}

void setup() {
	H.init(this);
	background(clrBg);

	int _w = width/2;
	int _h = height/2;
	int _m = 200; // margin

// ************************************************** ROW 1

	s1 = new HRect(100);
	s1.noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	s1.loc(_w-_m, _h-_m);

	s2 = new HRect(100);
	s2.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	s2.loc(_w, _h-_m);

	s3 = new HRect(100);
	s3.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	s3.rotation(45).loc(_w+_m, _h-_m);

// ************************************************** ROW 2

	s4 = new HRect();
	s4.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	s4.size(50,100).loc(_w-_m, _h);

	s5 = new HRect(100);
	s5.rounding(5).strokeWeight(3).stroke(#666666).fill(#ECECEC).anchorAt(H.CENTER);
	s5.size(150,100).loc(_w, _h);

	s6 = new HRect(100);
	s6.rounding(5).noStroke().fill(#ECECEC).anchorAt(H.CENTER);
	s6.visibility(false).loc(_w+_m, _h);

// ************************************************** ROW 3

	s7 = new HRect(100);
	s7.rounding(5).strokeWeight(6).stroke(#000000).fill(#ECECEC).alpha(100).anchorAt(H.CENTER);
	s7.loc(_w-_m, _h+_m);

	s8 = new HRect(100);
	s8.rounding(5).strokeWeight(6).stroke(#000000, 150).fill(#ECECEC, 50).anchorAt(H.CENTER);
	s8.loc(_w, _h+_m);

	s9 = new HRect(100);
	s9.rounding(5,10,20,30).strokeWeight(6).stroke(#000000, 100).fill(#ECECEC).anchorAt(H.CENTER);
	s9.loc(_w+_m, _h+_m);

}

void draw() {
	background(clrBg);
	visualizeHelper();

	s1.draw(this.g);
	s2.draw(this.g);
	s3.draw(this.g);

	s4.draw(this.g);
	s5.draw(this.g);
	s6.draw(this.g);

	s7.draw(this.g);
	s8.draw(this.g);
	s9.draw(this.g);
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
	ellipse(s3.x(), s3.y(), 6, 6);

	ellipse(s4.x(), s4.y(), 6, 6);
	ellipse(s5.x(), s5.y(), 6, 6);
	ellipse(s6.x(), s6.y(), 6, 6);

	ellipse(s7.x(), s7.y(), 6, 6);
	ellipse(s8.x(), s8.y(), 6, 6);
	ellipse(s9.x(), s9.y(), 6, 6);

// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, height/2, width, height/2);
	line(width/2, 0, width/2, height);
}
