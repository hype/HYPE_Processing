import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HBox d1;                // declare an HBox object/drawable

// **************************************************

PGraphics texBuffer;
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

	w = width/2;        // move the origin (0,0) to the center of the stage / x
	h = height/2;       // move the origin (0,0) to the center of the stage / y

	d1 = new HBox();    // create an HBox object
	d1.size(250); 	    // set the size of the object
	d1.stroke(#000000); // set the stroke color
	d1.fill(#FFFFFF);   // set the fill color
	d1.loc(w, h);       // set the location (x,y) of the object

	r1 = (HRect) new HRect().size(50).noStroke().fill(#FF3300).loc(0, 0).anchorAt(H.CENTER).rotate(45);

	texBuffer = createGraphics(canvasW, canvasH, P3D);

    canvas = new HCanvas(canvasW, canvasH, P3D).autoClear(false).fade(5);
	canvas.add( r1 ); // joshua/ben / not loving this... would be nice to have r1.draw(canvas) like we can do with generic PGraphics objects
}

void draw() {
	background(clrBg);

	r1.size( 20+((int)random(5)*20) ).loc( (int)random(canvasW), (int)random(canvasH));
	canvas.paintAll(texBuffer, false, 1); // joshua/ben / not loving this... need to add a run() method in HCanvas... for easy offscreen rendering

	image(canvas.graphics(), 0, 0, 200, 200); // preview texBuffer

	// Be wary when using these hints, they are there to help with z depth clipping issues.
	// They can have performance issues when there's a lot of overlapping objects on screen.
	// the clipping issues occur because we are painting with transparent PNGs

	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	lights();

	d1.texture( canvas.graphics() );
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
