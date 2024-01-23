import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;

// **************************************************

HIcosahedron d1;             // declare an HIcosahedron object

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);            // initialize HYPE library
	background(clrBg);

	w = width/2;             // move the origin (0,0) to the center of the stage / x
	h = height/2;            // move the origin (0,0) to the center of the stage / y

	d1 = new HIcosahedron(); // create an HIcosahedron object
	d1.size(200); 	         // set the size of the object
	d1.stroke(#000000);      // set the stroke color
	d1.fill(#FFFFFF);        // set the fill color
	d1.loc(w, h);            // set the location (x,y) of the object
}

void draw() {
	background(clrBg);

	lights();
	d1.rotationY( map(mouseX, 0, width, -180, 180) );    // rotate the object on the Y axis
	d1.draw(this.g);         // object.draw(where to draw) / this.g = processing stage

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

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
