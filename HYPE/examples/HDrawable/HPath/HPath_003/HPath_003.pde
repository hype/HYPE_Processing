import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;

// **************************************************

HPath s1, s2, s3;
HText t1;

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;

	// star( numPoints, innerRadius, rotation )
	s1 = (HPath) new HPath().star( 5, 0.5, 0 ).size(200).strokeWeight(4).stroke(#FF9900).fill(#111111).anchor(100,100).loc(w-275, h);
	s2 = (HPath) new HPath().star( 5, 0.5, -90 ).size(200).strokeWeight(4).stroke(#FF6600).fill(#111111).anchor(100,100).loc(w, h);
	s3 = (HPath) new HPath().star( 5, 0.5, 90 ).size(200).strokeWeight(4).stroke(#FF3300).fill(#111111).anchor(100,100).loc(w+275, h);

	t1 = (HText) new HText("Heavy Metal").size(18).strokeWeight(0).noStroke().fill(#FF3300).loc(s3.x(), h+125);
}

void draw() {
	background(clrBg);

	s1.draw(this.g);
	s2.draw(this.g);
	s3.draw(this.g);

	t1.draw(this.g);

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

// visualize the x,y anchor point of the object

	strokeWeight(2);
	stroke(#0095a8);
	fill(#333333);
	ellipse(s1.x(), s1.y(), 6, 6);
	ellipse(s2.x(), s2.y(), 6, 6);
	ellipse(s3.x(), s3.y(), 6, 6);

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
