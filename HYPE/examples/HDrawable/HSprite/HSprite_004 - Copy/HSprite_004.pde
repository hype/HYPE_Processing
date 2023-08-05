import hype.*;
import hype.extended.behavior.HOscillator;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #FF3300;
String pathToData = "../data/";

// **************************************************

// SPRITES

HSprite s1, s2, s3, s4, s5, s6, s7, s8, s9;
int     spriteSize   = 225;

// **************************************************

// COLOR

PImage      i1;
HOscillator clr;
HRect       clrMarker;

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

	i1 = loadImage(pathToData + "color.png");
	clr = new HOscillator().range(0, 900).speed(1).freq(2).waveform(H.SAW);
	clrMarker = (HRect) new HRect(2, 40).strokeWeight(0).noStroke().fill(#CCCCCC).anchorAt(H.CENTER).loc(0, 10);

	s1 = (HSprite) new HSprite().texture(pathToData + "tex1.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w-275, h-275);
	s2 = (HSprite) new HSprite().texture(pathToData + "tex2.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w, h-275);
	s3 = (HSprite) new HSprite().texture(pathToData + "tex3.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w+275, h-275);

	s4 = (HSprite) new HSprite().texture(pathToData + "tex1.png").size(spriteSize).anchorAt(H.CENTER).loc(w-275, h);
	s5 = (HSprite) new HSprite().texture(pathToData + "tex2.png").size(spriteSize).anchorAt(H.CENTER).loc(w, h);
	s6 = (HSprite) new HSprite().texture(pathToData + "tex3.png").size(spriteSize).anchorAt(H.CENTER).loc(w+275, h);

	s7 = (HSprite) new HSprite().texture(pathToData + "img1.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w-275, h+275);
	s8 = (HSprite) new HSprite().texture(pathToData + "img2.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w, h+275);
	s9 = (HSprite) new HSprite().texture(pathToData + "img3.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w+275, h+275);
}

void draw() {
	background(clrBg);
	noTint();

	image(i1, 0, 0);
	clr.run();
	clrMarker.x(clr.cur()).draw(this.g);

	color _c = i1.get( (int)clr.cur(), 1);

	s1.fill(_c).draw(this.g);
	s2.fill(_c).draw(this.g);
	s3.fill(_c).draw(this.g);

	s4.fill(_c).draw(this.g);
	s5.fill(_c).draw(this.g);
	s6.fill(_c).draw(this.g);

	s7.fill(_c).draw(this.g);
	s8.fill(_c).draw(this.g);
	s9.fill(_c).draw(this.g);

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
