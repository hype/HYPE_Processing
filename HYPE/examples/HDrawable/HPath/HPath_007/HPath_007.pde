import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

PImage i1, i2, i3;
HPath s1, s2, s3, s4, s5, s6, s7, s8, s9;

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;

	i1 = loadImage(pathToData + "tex1.png");
	i2 = loadImage(pathToData + "tex2.png");
	i3 = loadImage(pathToData + "tex3.png");

// ************************************************** / ROW 1

	s1 = (HPath) new HPath().texture(i1).star( 5, 0.75 );
	s1.size(200).noStroke().fill(#FF9900).anchor(100,100).rotation(-90).loc(w-275, h-275);

	s2 = (HPath) new HPath().texture(i1).star( 5, 0.50 );
	s2.size(200).noStroke().fill(#FF6600).anchor(100,100).rotation(-90).loc(w, h-275);

	s3 = (HPath) new HPath().texture(i1).star( 5, 0.25 );
	s3.size(200).noStroke().fill(#FF3300).anchor(100,100).rotation(-90).loc(w+275, h-275);

// ************************************************** / ROW 2

	s4 = (HPath) new HPath().texture(i2).polygon( 6 );
	s4.size(200).noStroke().fill(#FF9900).anchor(100,100).rotation(-90).loc(w-275, h);

	s5 = (HPath) new HPath().texture(i2).polygon( 7 );
	s5.size(200).noStroke().fill(#FF6600).anchor(100,100).rotation(-90).loc(w, h);

	s6 = (HPath) new HPath().texture(i2).polygon( 8 );
	s6.size(200).noStroke().fill(#FF3300).anchor(100,100).rotation(-90).loc(w+275, h);

// ************************************************** / ROW 3

	s7 = (HPath) new HPath().texture(i3).triangle(H.ISOCELES, H.TOP );
	s7.size(200).noStroke().fill(#FF9900).anchor(100,100).rotation(-90).loc(w-275, h+275);

	s8 = (HPath) new HPath().texture(i3).triangle(H.ISOCELES, H.RIGHT);
	s8.size(200).noStroke().fill(#FF6600).anchor(100,100).rotation(-90).loc(w, h+275);

	s9 = (HPath) new HPath().texture(i3).triangle(H.ISOCELES, H.BOTTOM );
	s9.size(200).noStroke().fill(#FF3300).anchor(100,100).rotation(-90).loc(w+275, h+275);
}

void draw() {
	background(clrBg);

	s1.draw(this.g);
	s2.draw(this.g);
	s3.draw(this.g);

	s4.draw(this.g);
	s5.draw(this.g);
	s6.draw(this.g);

	s7.draw(this.g);
	s8.draw(this.g);
	s9.draw(this.g);

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

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

	ellipse(s7.x(), s8.y(), 6, 6);
	ellipse(s8.x(), s8.y(), 6, 6);
	ellipse(s9.x(), s9.y(), 6, 6);

// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, h, width, h);
	line(w, 0, w, height);

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
