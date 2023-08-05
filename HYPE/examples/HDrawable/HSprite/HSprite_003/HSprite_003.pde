import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #FF3300;
String pathToData = "../data/";

// **************************************************

PImage  i1, i2, i3;
HSprite s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12;

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

	s1 = (HSprite) new HSprite().texture(i1).size(280, 280).loc(w-440, h-440);
	s2 = (HSprite) s1.createCopy().size(590, 280).loc(w-150, h-440);

	s3 = (HSprite) new HSprite().texture(i2).size(280, 530).loc(w-440, h-150);
	s4 = (HSprite) s3.createCopy().size(230, 230).loc(w-150, h-150);
	s5 = (HSprite) s3.createCopy().size(170, 170).loc(w+90, h-150);
	s6 = (HSprite) s3.createCopy().size(110, 110).loc(w+270, h-150);
	s7 = (HSprite) s3.createCopy().size(50, 50).loc(w+390, h-150);

	s8 = (HSprite) new HSprite().texture(i3).size(280, 50).loc(w-440, h+390);
	s9 = (HSprite) s8.createCopy().size(230, 350).loc(w-150, h+90);
	s10 = (HSprite) s8.createCopy().size(170, 410).loc(w+90, h+30);
	s11 = (HSprite) s8.createCopy().size(110, 470).loc(w+270, h-30);
	s12 = (HSprite) s8.createCopy().size(50, 530).loc(w+390, h-90);
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
	s10.draw(this.g);
	s11.draw(this.g);
	s12.draw(this.g);

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
	ellipse(s7.x(), s7.y(), 6, 6);
	ellipse(s8.x(), s8.y(), 6, 6);
	ellipse(s9.x(), s9.y(), 6, 6);
	ellipse(s10.x(), s10.y(), 6, 6);
	ellipse(s11.x(), s11.y(), 6, 6);
	ellipse(s12.x(), s12.y(), 6, 6);

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
