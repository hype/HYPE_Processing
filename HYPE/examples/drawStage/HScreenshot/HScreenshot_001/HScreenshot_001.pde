import hype.*;
import hype.extended.colorist.HColorPool;

HRect       r;
HColorPool  colors;

HScreenshot ss;
boolean     letsRecord = false;

void setup() {
	size(640,640); 
	H.init(this).background(#242424);

	// screenshots will be saved in a new folder called "output" (DEFAULT)
	// screenshots will be saved as a sequence / "frame00001", "frame00002", "frame00003", etc.
	// screenshots will be saved as a ".png" (DEFAULT)

	ss = new HScreenshot().filename("frame");

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);
	H.add( r = new HRect(100).rounding(5) ).stroke(0,55).fill(colors.getColor()).anchorAt(H.CENTER).rotate(45).loc(width/2,height/2);
}

void draw() {
	r.fill(colors.getColor()).size(50+((int)random(5)*25)).loc( (int)random(width), (int)random(height));

	H.drawStage();

	if(letsRecord) {
		ss.capture(frameCount).run();
		letsRecord = false;
	}
} 

// after the "r" key is pressed on your keyboard, it will save 1 image of the current state of the sketch

void keyPressed() {
	switch (key) {
		case 'r':
			letsRecord = true; 
		break;
	}
}
