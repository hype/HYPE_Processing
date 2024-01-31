import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;

// **************************************************

HSphere d1;                // declare an HSphere object/drawable

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);          // initialize HYPE library
	background(clrBg);

	w = stageW/2;          // move the origin (0,0) to the center of the stage / x
	h = stageH/2;          // move the origin (0,0) to the center of the stage / y

	d1 = new HSphere();    // create an HSphere object
	d1.sphereDetail(20);   // set the detail of the object // if this is set any other call to sphereDetail() will be ignored
	d1.size(200); 	       // set the size of the object
	d1.stroke(#000000);    // set the stroke color
	d1.fill(#FFFFFF);      // set the fill color
	d1.anchorAt(H.CENTER); // set the anchor point of the object
	d1.loc(w, h);          // set the location (x,y) of the object
}

void draw() {
	background(clrBg);

	lights();
	sphereDetail(100); // ignored because it was set on line 25 of the d1 object

	d1.rotationY( map(mouseX, 0, stageW, -180, 180) ); // rotate the object on the Y axis
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
