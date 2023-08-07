import hype.*;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HShape s1, s2, s3, s4, s5, s6, s7, s8, s9;
int    sMargin = 290;

void settings() {
	size(stageW, stageH);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;

	s1 = (HShape) new HShape(pathToData + "bot1.svg").scale(0.9).anchorAt(H.CENTER).loc(w-sMargin, h-sMargin);
	s1.enableStyle(false).strokeWeight(3).stroke(0).fill(255);

	s2 = (HShape) s1.createCopy().loc(w, h-sMargin).stroke(H.RED, 255).fill(H.MAGENTA, 50);

	s3 = (HShape) s1.createCopy().loc(w+sMargin, h-sMargin).stroke(H.RED, 100).fill(H.GREY, 100);

	s4 = (HShape) s1.createCopy().loc(w-sMargin, h).stroke(H.GREEN, 255).fill(H.RED, 100);

	s5 = (HShape) s1.createCopy().loc(w, h).stroke(H.WHITE, 100).fill(H.GREEN, 50);

	s6 = (HShape) s1.createCopy().loc(w+sMargin, h).strokeWeight(0).noStroke().fill(H.MAGENTA, 100);

	s7 = (HShape) new HShape(pathToData + "bot1.svg").scale(0.9).anchorAt(H.CENTER).loc(w-sMargin, h+sMargin);
	s7.enableStyle(false).strokeWeight(3).stroke(H.GREEN, 255).fill(H.RED, 255);
	for (int i=0; i<=s7.numChildren(); i+=3) s7.setChild(i); //set every third item to have a green stroke and red fill

	s8 = (HShape) new HShape(pathToData + "bot1.svg").scale(0.9).anchorAt(H.CENTER).loc(w, h+sMargin);
	s8.enableStyle(false).strokeWeight(3).stroke(H.MAGENTA, 150).noFill();
	for (int i=0; i<=s8.numChildren(); i+=2) s8.setChild(i); //set every second item to have a maagenta stroke and no fill

	s9 = (HShape) new HShape(pathToData + "bot1.svg").scale(0.9).anchorAt(H.CENTER).loc(w+sMargin, h+sMargin);
	s9.enableStyle(false).strokeWeight(3).stroke(H.RED, 255).fill(H.YELLOW, 255);
	for (int i=0; i<=s9.numChildren(); i+=3) s9.setChild(i); //starting from the first item, set every third item to have a yellow fill and no stroke
	s9.stroke(H.GREEN, 255).fill(H.RED, 155);
	for (int i=1; i<=s9.numChildren(); i+=3) s9.setChild(i); //starting from the second item, set every third item to have a red fill and green stroke

}

void draw() {
	background(clrBg);

	s1.draw(this.g);
	s2.draw(this.g);
	s3.draw(this.g);

	s4.draw(this.g);
	s5.draw(this.g);
	s6.draw(this.g);

	s7.draw(this.g);
	s8.draw(this.g);
	s9.draw(this.g);

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
