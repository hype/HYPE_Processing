import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HBox s1;                // declare an HBox object

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);       // initialize HYPE library
	background(clrBg);

	w = width/2;        // move the origin (0,0) to the center of the stage / x
	h = height/2;       // move the origin (0,0) to the center of the stage / y

	s1 = new HBox();    // create an HBox object
	s1.size(250); 	    // set the size of the object
	s1.stroke(#000000); // set the stroke color
	s1.fill(#FFFFFF);   // set the fill color
	s1.loc(w, h);       // set the location (x,y) of the object

	// set the texture of the object
	// when calling texture() the single image is mapped to all 6 sides of the object
	s1.texture(pathToData + "tex_00.png");
}

void draw() {
	background(clrBg);

	// Be wary when using these hints, they are there to help with z depth clipping issues.
	// They can have performance issues when there's a lot of overlapping objects on screen.
	// the clipping issues occur because we are painting with transparent PNGs

	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	lights();

	s1.rotationY( map(mouseX, 0, width,  -180, 180) ); // rotate the object on the Y axis
	s1.rotationX( map(mouseY, 0, height, -180, 180) ); // rotate the object on the X axis
	s1.draw(this.g); // object.draw(where to draw) / this.g = processing stage

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
