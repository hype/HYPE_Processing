import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;

// **************************************************

HBox d1;                // declare an HBox object/drawable

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);       // initialize HYPE library
	background(clrBg);

	w = width/2;        // move the origin (0,0) to the center of the stage / x
	h = height/2;       // move the origin (0,0) to the center of the stage / y

	d1 = new HBox();    // create an HBox object
	d1.size(250); 	    // set the size of the object
	d1.strokeWeight(0); // set the stroke weight
	d1.noStroke();      // set no stroke
	d1.fill(#FFFFFF);   // set the fill color
	d1.loc(w, h);       // set the location (x,y) of the object
}

void draw() {
	background(clrBg);

	pointLight(255,  51,   0,        0, height/2, 300); // orange
	pointLight(0,   149, 168,    width, height/2, 300); // teal
	pointLight(255, 204,   0,  width/2, height/2, 400); // yellow

	d1.rotationY( map(mouseX, 0, width,  -180, 180) ); // rotate the object on the Y axis
	d1.rotationX( map(mouseY, 0, height, -180, 180) ); // rotate the object on the X axis
	d1.draw(this.g); // object.draw(where to draw) / this.g = processing stage

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
