import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HCylinder d1;             // declare an HCylinder object/drawable

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);         // initialize HYPE library
	background(clrBg);

	w = stageW/2;         // move the origin (0,0) to the center of the stage / x
	h = stageH/2;         // move the origin (0,0) to the center of the stage / y

	d1 = new HCylinder(); // create an HCylinder object
	d1.size(250); 	      // set the size of the object
	d1.stroke(#CCCCCC);   // set the stroke color
	d1.fill(#FF3300);     // set the fill color
	d1.loc(w, h);         // set the location (x,y) of the object

	d1.sides(12);		  // set the number of sides of the object / default is 72
	d1.strokeSides(true); // set the stroke of the sides of the object / default is false
	d1.drawTop(false);    // set the top of the cylinder to hidden / default is true
	d1.drawBottom(false); // set the bottom of the cylinder to hidden / default is true

	// set the texture around the cylindrical surface of the cylinder
	// texture doesnt get applied to the top and bottom of the cylinder
	d1.texture(pathToData + "tex1.png");
}

void draw() {
	background(clrBg);

	lights();

	d1.rotationY( map(mouseX, 0, stageW, -180, 180) ); // rotate the object on the Y axis
	d1.rotationX( map(mouseY, 0, stageH, -180, 180) ); // rotate the object on the X axis
	d1.draw(this.g); // object.draw(where to draw) / this.g = processing stage

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

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