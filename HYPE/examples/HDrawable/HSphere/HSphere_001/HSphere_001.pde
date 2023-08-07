import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;

// **************************************************

HSphere s1;                // declare an HSphere object

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);          // initialize HYPE library
	background(clrBg);

	w = width/2;           // move the origin (0,0) to the center of the stage / x
	h = height/2;          // move the origin (0,0) to the center of the stage / y

	s1 = new HSphere();    // create an HSphere object
	s1.sphereDetail(20);   // set the detail of the object // if this is set any other call to sphereDetail() will be ignored
	s1.size(200); 	       // set the size of the object
	s1.stroke(#000000);    // set the stroke color
	s1.fill(#FFFFFF);      // set the fill color
	s1.anchorAt(H.CENTER); // set the anchor point of the object
	s1.loc(w, h);          // set the location (x,y) of the object
}

void draw() {
	background(clrBg);

	lights();
	sphereDetail(100); // ignored because it was set in the constructor

	s1.rotationY( map(mouseX, 0, width, -180, 180) ); // rotate the object on the Y axis
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
