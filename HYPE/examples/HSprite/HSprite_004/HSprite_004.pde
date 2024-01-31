import hype.*;
import hype.extended.behavior.HOscillator;

int     stageW = 900;
int     stageH = 900;
int     w, h;
color   clrBg = #FF3300;
String  pathToData = "../data/";

// **************************************************

// SPRITES

HSprite d1, d2, d3, d4, d5, d6, d7, d8, d9;
int     spriteSize   = 225;

// **************************************************

// COLOR

HImage      i1;
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

	w = stageW/2;
	h = stageH/2;

	i1 = (HImage) new HImage(pathToData + "color.png").loc(0, 0);
	clr = new HOscillator().range(0, i1.width()-1).speed(1).freq(2).waveform(H.SAW);
	clrMarker = (HRect) new HRect(2, 40).strokeWeight(0).noStroke().fill(#CCCCCC).anchorAt(H.CENTER).loc(0, 10);

	d1 = (HSprite) new HSprite().texture(pathToData + "tex1.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w-275, h-275);
	d2 = (HSprite) new HSprite().texture(pathToData + "tex2.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w, h-275);
	d3 = (HSprite) new HSprite().texture(pathToData + "tex3.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w+275, h-275);

	d4 = (HSprite) new HSprite().texture(pathToData + "tex1.png").size(spriteSize).anchorAt(H.CENTER).loc(w-275, h);
	d5 = (HSprite) new HSprite().texture(pathToData + "tex2.png").size(spriteSize).anchorAt(H.CENTER).loc(w, h);
	d6 = (HSprite) new HSprite().texture(pathToData + "tex3.png").size(spriteSize).anchorAt(H.CENTER).loc(w+275, h);

	d7 = (HSprite) new HSprite().texture(pathToData + "img1.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w-275, h+275);
	d8 = (HSprite) new HSprite().texture(pathToData + "img2.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w, h+275);
	d9 = (HSprite) new HSprite().texture(pathToData + "img3.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w+275, h+275);
}

void draw() {
	background(clrBg);
	noTint();

	i1.draw(this.g);
	clr.run();
	clrMarker.x(clr.cur()).draw(this.g);

	color _c = i1.getColor( clr.cur(), 1 );

	d1.fill(_c).draw(this.g);
	d2.fill(_c).draw(this.g);
	d3.fill(_c).draw(this.g);

	d4.fill(_c).draw(this.g);
	d5.fill(_c).draw(this.g);
	d6.fill(_c).draw(this.g);

	d7.fill(_c).draw(this.g);
	d8.fill(_c).draw(this.g);
	d9.fill(_c).draw(this.g);

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

	// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333); 
	ellipse(d1.x(), d1.y(), 6, 6);
	ellipse(d2.x(), d2.y(), 6, 6);
	ellipse(d3.x(), d3.y(), 6, 6);

	ellipse(d4.x(), d4.y(), 6, 6);
	ellipse(d5.x(), d5.y(), 6, 6);
	ellipse(d6.x(), d6.y(), 6, 6);

	ellipse(d7.x(), d7.y(), 6, 6);
	ellipse(d8.x(), d8.y(), 6, 6);
	ellipse(d9.x(), d9.y(), 6, 6);

	// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, h, stageW, h);
	line(w, 0, w, stageH);

	// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
