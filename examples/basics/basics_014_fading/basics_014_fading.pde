import hype.*;
import hype.extended.colorist.HColorPool;

HColorPool colors;
PGraphics  canvas1;
HCanvas    canvas2;
HRect      r;

int        countDown = 5;
int        count     = 0;
int        ranScale;

void setup() {
	size(640,640);
	H.init(this).background(#000000);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	canvas1 = createGraphics(320,640);

	canvas2 = new HCanvas().autoClear(false).fade(2);
	H.add(canvas2);

	ranScale = 25+((int)random(5)*25);

	r = new HRect();
	r.noStroke().fill( colors.getColor() ).size( ranScale , ranScale ).loc( (width/2) + (int)random(width/2) , (int)random(height) );
	canvas2.add(r);
}

void draw() {
	H.drawStage();

	// pick a random RECT size

	ranScale = 25+((int)random(5)*25);

	// move the RECT randomly on the PGraphic

	canvas1.beginDraw();
		canvas1.noStroke();
		canvas1.fill(#000000, 5);
		canvas1.rect(0, 0, width, height);
		if (count++ >= countDown) {
			canvas1.noStroke();
			canvas1.fill( colors.getColor() );
			canvas1.rect( (int)random(width/2), (int)random(height), ranScale, ranScale);
			count = 0;
		}
	canvas1.endDraw();
	image(canvas1, 0, 0);

	// move the RECT randomly on the HCanvas

	if (count >= countDown) {
		r.fill( colors.getColor() ).size( ranScale , ranScale ).loc( (width/2) + (int)random(width/2) , (int)random(height) );
	}

	// add type and draw a line seperating the left and right sides

	textSize(18); text("PGraphics fading", 90, 30);
	textSize(18); text("HCanvas fading", 420, 30);
	stroke(#FFFFFF); line(320, 0, 320, 640);
}
