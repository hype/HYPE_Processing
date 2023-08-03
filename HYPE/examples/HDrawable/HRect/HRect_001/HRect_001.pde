import hype.*;

int   stageW = 800;
int   stageH = 800;
color clrBg  = #242424;

// **************************************************

HRect s1;                            // declare an HRect object

void settings() {
	size(stageW, stageH, P3D);
}

void setup() {
	H.init(this);                    // initialize HYPE library
	background(clrBg);

	s1 = new HRect(100);             // create an HRext object with size 100
	s1.noStroke();                   // remove the stroke
	s1.fill(#FF3300);                // set the fill color
	s1.loc( (width/2), (height/2) ); // set the location (x,y) of the object
}

void draw() {
	background(clrBg);

	s1.draw(this.g);                 // object.draw(where to draw) / this.g = processing stage

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333); 
	ellipse(s1.x(), s1.x(), 6, 6);

// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, height/2, width, height/2);
	line(width/2, 0, width/2, height);
}
