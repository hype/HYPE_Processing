import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h;
color  clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HBox d1;                // declare an HBox object/drawable

// **************************************************

HCanvas   canvas;
int       canvasW = 500;
int       canvasH = 500;

HRect r1;               // declare an HRect object

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);       // initialize HYPE library
	background(clrBg);

	w = stageW/2;       // move the origin (0,0) to the center of the stage / x
	h = stageH/2;       // move the origin (0,0) to the center of the stage / y

	d1 = new HBox();    // create an HBox object
	d1.size(250); 	    // set the size of the object
	d1.stroke(#000000); // set the stroke color
	d1.fill(#FFFFFF);   // set the fill color
	d1.loc(w, h);       // set the location (x,y) of the object

	r1 = (HRect) new HRect().size(50).noStroke().fill(#FF3300).loc(0, 0).anchorAt(H.CENTER).rotate(45);

    canvas = new HCanvas(canvasW, canvasH, P3D).autoClear(false).fade(5);
}

void draw() {
	background(clrBg);

	r1.size( 20+((int)random(5)*20) ).loc( (int)random(canvasW), (int)random(canvasH));

	canvas.graphics().beginDraw(); // lets start to paint to the HCanvas
	r1.draw(canvas.graphics());    // lets draw the object to the HCanvas
	canvas.graphics().endDraw();   // lets stop painting to the HCanvas

	canvas.run(); // lets paint the HCanvas / this happens offscreen / use canvas.graphics() to see what was painted

	image(canvas.graphics(), 0, 0, 200, 200); // preview what was painted to the HCanvas

	// Be wary when using these hints, they are there to help with z depth clipping issues.
	// They can have performance issues when there's a lot of overlapping objects on screen.
	// the clipping issues occur because we are painting with transparent PNGs

	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	lights();

	d1.texture( canvas.graphics() );
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
