import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;

int   stageW = 900;
int   stageH = 900;
int   w, h;
color clrBg  = #242424;
String pathToData = "../data/";

// **************************************************

HShape        d1;
HOscillator[] oscS;
color[]       pickedS;
color[]       pickedF;

HColorPool colors1 = new HColorPool(#006600, #009900, #00CC00, #00616F, #0095A8, #FF3300, #FF6600, #FF9900);
HColorPool colors2 = new HColorPool(#FFFFFF, #CCCCCC, #999999, #666666, #333333, #242424, #111111, #FF3300);

void settings() {
	size(stageW, stageH);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;

	d1 = (HShape) new HShape(pathToData + "bot1.svg");
	d1.size(600);
	d1.enableStyle(false);
	d1.strokeWeight(1);
	d1.stroke(#FFFFFF);
	d1.fill(#111111);
	d1.anchorAt(H.CENTER).loc(w, h);

	oscS = new HOscillator[d1.numChildren()];
	pickedS = new color[d1.numChildren()];
	pickedF = new color[d1.numChildren()];

	for (int i=0; i<d1.numChildren(); ++i) {
		oscS[i] = new HOscillator().range(0.1, 5).speed(1).freq( (int)random(5,10) ).currentStep( (int)random(999) ).waveform(H.EASE);
		pickedS[i] = colors1.getColor();
		pickedF[i] = colors2.getColor();
	}

}

void draw() {
	background(clrBg);

	for (int i=0; i<d1.numChildren(); ++i) {
		oscS[i].run();
		d1.strokeWeight( oscS[i].cur() );
		if(frameCount%90==0) {
			pickedS[i] = colors1.getColor();
			pickedF[i] = colors2.getColor();
		}
		d1.setChild(i).stroke( pickedS[i] ).fill( pickedF[i] );
	}

	d1.draw(this.g);

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


