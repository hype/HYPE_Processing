import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #FF3300;
String pathToData = "../data/";

// **************************************************

HSprite s1, s2, s3, s4, s5, s6;
int     spriteSize   = 225;

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;

	// JPG textures

	s1 = (HSprite) new HSprite().texture(pathToData + "tex1.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w-275, h-150);
	s2 = (HSprite) new HSprite().texture(pathToData + "tex2.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w, h-150);
	s3 = (HSprite) new HSprite().texture(pathToData + "tex3.jpg").size(spriteSize).anchorAt(H.CENTER).loc(w+275, h-150);

	// PNG textures / being the ideal texture to map to HSprite / nothing but transparency love

	s4 = (HSprite) new HSprite().texture(pathToData + "tex1.png").size(spriteSize).anchorAt(H.CENTER).loc(w-275, h+150);
	s5 = (HSprite) new HSprite().texture(pathToData + "tex2.png").size(spriteSize).anchorAt(H.CENTER).loc(w, h+150);
	s6 = (HSprite) new HSprite().texture(pathToData + "tex3.png").size(spriteSize).anchorAt(H.CENTER).loc(w+275, h+150);
}

void draw() {
	background(clrBg);

	s1.draw(this.g);
	s2.draw(this.g);
	s3.draw(this.g);

	s4.draw(this.g);
	s5.draw(this.g);
	s6.draw(this.g);

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
