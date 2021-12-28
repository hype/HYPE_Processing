import hype.*;
import hype.extended.colorist.HColorPool;

HColorPool colors;
HCanvas    canvas1, canvas2, canvas3;
HRect      rect1, rect2, rect3;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	canvas3 = new HCanvas().autoClear(false).fade(6);
	canvas2 = new HCanvas().autoClear(false).fade(4);
	canvas1 = new HCanvas().autoClear(false).fade(2);

	H.add(canvas3);
	H.add(canvas2);
	H.add(canvas1);

	int ranX = (int)random(width);
	int ranY = (int)random(height);

	int scale1 = 5+((int)random(5)*5);
	int scale2 = (scale1+10)+((int)random(10)*5);
	int scale3 = (scale2+20)+((int)random(5)*10);

	rect1 = new HRect().rounding(5);
	rect1.noStroke().fill(colors.getColor()).size(scale1,scale1).loc(ranX,ranY).anchorAt(H.CENTER).rotation(45);
	canvas1.add(rect1);

	rect2 = new HRect().rounding(5);
	rect2.noStroke().fill(colors.getColor()).size(scale2,scale2).loc(ranX,ranY).anchorAt(H.CENTER).rotation(45);
	canvas2.add(rect2);

	rect3 = new HRect().rounding(5);
	rect3.noStroke().fill(colors.getColor()).size(scale3,scale3).loc(ranX,ranY).anchorAt(H.CENTER).rotation(45);
	canvas3.add(rect3);
}

void draw() {
	int ranX = (int)random(width);
	int ranY = (int)random(height);

	int scale1 = 5+((int)random(5)*5);
	int scale2 = (scale1+10)+((int)random(10)*5);
	int scale3 = (scale2+20)+((int)random(5)*10);

	rect1.fill(colors.getColor()).size(scale1,scale1).loc(ranX,ranY);
	rect2.fill(colors.getColor()).size(scale2,scale2).loc(ranX,ranY);
	rect3.fill(colors.getColor()).size(scale3,scale3).loc(ranX,ranY);

	H.drawStage();
}
