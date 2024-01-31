import hype.*;

int    stageW = 900;
int    stageH = 900;
int    w, h, m;
color  clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HShape d1, d2, d3, d4, d5, d6, d7, d8, d9;

// **************************************************

void settings() {
	size(stageW, stageH);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = stageW/2;
	h = stageH/2;
	m = 290;

	d1 = (HShape) new HShape(pathToData + "bot1.svg").scale(0.9).anchorAt(H.CENTER).loc(w-m, h-m);
	d1.enableStyle(false).strokeWeight(3).stroke(0).fill(255);

	d2 = (HShape) d1.createCopy().loc(w, h-m).stroke(H.RED, 255).fill(H.MAGENTA, 50);

	d3 = (HShape) d1.createCopy().loc(w+m, h-m).stroke(H.RED, 100).fill(H.GREY, 100);

	d4 = (HShape) d1.createCopy().loc(w-m, h).stroke(H.GREEN, 255).fill(H.RED, 100);

	d5 = (HShape) d1.createCopy().loc(w, h).stroke(H.WHITE, 100).fill(H.GREEN, 50);

	d6 = (HShape) d1.createCopy().loc(w+m, h).strokeWeight(0).noStroke().fill(H.MAGENTA, 100);

	d7 = (HShape) new HShape(pathToData + "bot1.svg").scale(0.9).anchorAt(H.CENTER).loc(w-m, h+m);
	d7.enableStyle(false).strokeWeight(3).stroke(H.GREEN, 255).fill(H.RED, 255);
	for (int i=0; i<=d7.numChildren(); i+=3) d7.setChild(i); //set every third item to have a green stroke and red fill

	d8 = (HShape) new HShape(pathToData + "bot1.svg").scale(0.9).anchorAt(H.CENTER).loc(w, h+m);
	d8.enableStyle(false).strokeWeight(3).stroke(H.MAGENTA, 150).noFill();
	for (int i=0; i<=d8.numChildren(); i+=2) d8.setChild(i); //set every second item to have a maagenta stroke and no fill

	d9 = (HShape) new HShape(pathToData + "bot1.svg").scale(0.9).anchorAt(H.CENTER).loc(w+m, h+m);
	d9.enableStyle(false).strokeWeight(3).stroke(H.RED, 255).fill(H.YELLOW, 255);
	for (int i=0; i<=d9.numChildren(); i+=3) d9.setChild(i); //starting from the first item, set every third item to have a yellow fill and no stroke
	d9.stroke(H.GREEN, 255).fill(H.RED, 155);
	for (int i=1; i<=d9.numChildren(); i+=3) d9.setChild(i); //starting from the second item, set every third item to have a red fill and green stroke

}

void draw() {
	background(clrBg);

	d1.draw(this.g);
	d2.draw(this.g);
	d3.draw(this.g);

	d4.draw(this.g);
	d5.draw(this.g);
	d6.draw(this.g);

	d7.draw(this.g);
	d8.draw(this.g);
	d9.draw(this.g);

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
