import hype.*;

int     stageW = 900;
int     stageH = 900;
int     w, h;
color   clrBg = #FF3300;
String  pathToData = "../data/";

// **************************************************

HSprite d1, d2, d3, d4, d5, d6;
int     spriteSize = 225;
int     mX = 275;
int     mY = 150;

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

	// JPG textures

	d1 = (HSprite) new HSprite().texture(pathToData + "tex1.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w-mX, h-mY);
	d2 = (HSprite) new HSprite().texture(pathToData + "tex2.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w,    h-mY);
	d3 = (HSprite) new HSprite().texture(pathToData + "tex3.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w+mX, h-mY);

	// PNG textures / being the ideal texture to map to HSprite / nothing but transparency love

	d4 = (HSprite) new HSprite().texture(pathToData + "tex1.png").size(spriteSize).anchorAt(H.CENTER).loc(w-mX, h+mY);
	d5 = (HSprite) new HSprite().texture(pathToData + "tex2.png").size(spriteSize).anchorAt(H.CENTER).loc(w,    h+mY);
	d6 = (HSprite) new HSprite().texture(pathToData + "tex3.png").size(spriteSize).anchorAt(H.CENTER).loc(w+mX, h+mY);
}

void draw() {
	background(clrBg);

	d1.draw(this.g);
	d2.draw(this.g);
	d3.draw(this.g);

	d4.draw(this.g);
	d5.draw(this.g);
	d6.draw(this.g);

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
