import hype.*;

int     stageW = 900;
int     stageH = 900;
int     w, h;
color   clrBg = #FF3300;
String  pathToData = "../data/";

// **************************************************

PImage  i1, i2, i3;
HSprite d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12;

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

	i1 = loadImage(pathToData + "tex1.png");
	i2 = loadImage(pathToData + "tex2.png");
	i3 = loadImage(pathToData + "tex3.png");

	d1 = (HSprite) new HSprite().texture(i1).size(280, 280).loc(w-440, h-440);
	d2 = (HSprite) d1.createCopy().size(590, 280).loc(w-150, h-440);

	d3 = (HSprite) new HSprite().texture(i2).size(280, 530).loc(w-440, h-150);
	d4 = (HSprite) d3.createCopy().size(230, 230).loc(w-150, h-150);
	d5 = (HSprite) d3.createCopy().size(170, 170).loc(w+90, h-150);
	d6 = (HSprite) d3.createCopy().size(110, 110).loc(w+270, h-150);
	d7 = (HSprite) d3.createCopy().size(50, 50).loc(w+390, h-150);

	d8 = (HSprite) new HSprite().texture(i3).size(280, 50).loc(w-440, h+390);
	d9 = (HSprite)  d8.createCopy().size(230, 350).loc(w-150, h+90);
	d10 = (HSprite) d8.createCopy().size(170, 410).loc(w+90, h+30);
	d11 = (HSprite) d8.createCopy().size(110, 470).loc(w+270, h-30);
	d12 = (HSprite) d8.createCopy().size(50, 530).loc(w+390, h-90);
}

void draw() {
	background(clrBg);

	d1.draw(this.g);
	d2.draw(this.g);
	d3.draw(this.g);
	d4.draw(this.g);
	d5.draw(this.g);
	d6.draw(this.g);
	d7.draw(this.g);
	d8.draw(this.g);
	d9.draw(this.g);
	d10.draw(this.g);
	d11.draw(this.g);
	d12.draw(this.g);

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
	ellipse(d10.x(), d10.y(), 6, 6);
	ellipse(d11.x(), d11.y(), 6, 6);
	ellipse(d12.x(), d12.y(), 6, 6);

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
