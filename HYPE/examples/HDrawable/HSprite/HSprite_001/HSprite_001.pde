import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg = #242424;
String pathToData = "../data/";          // relative path to the data folder

// **************************************************

HSprite s1;                              // declare an HSprite object

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);                        // initialize HYPE library
	background(clrBg);

	w = width/2;                         // move the origin (0,0) to the center of the stage / x
	h = height/2;                        // move the origin (0,0) to the center of the stage / y

	s1 = new HSprite();                  // create an HSprite object
	s1.texture(pathToData + "tex1.jpg"); // set the texture of the object
	s1.size(300);                        // set the size of the object
	s1.anchorAt(H.CENTER);               // set the anchor point of the object
	s1.loc(w, h);                        // set the location (x,y) of the object
}

void draw() {
	background(clrBg);

	s1.draw(this.g);                     // object.draw(where to draw) / this.g = processing stage

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333); 
	ellipse(s1.x(), s1.y(), 6, 6);

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
