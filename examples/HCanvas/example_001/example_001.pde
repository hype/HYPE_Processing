HColorPool colors;
HCanvas canvas1, canvas2, canvas3;
HRect r1, r2, r3;

int countDown = 5;
int count = 0;
int ranX, ranY;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	canvas1 = new HCanvas().autoClear(false).fade(2);
	canvas2 = new HCanvas().autoClear(false).fade(4);
	canvas3 = new HCanvas().autoClear(false).fade(6);

	H.add(canvas3);
	H.add(canvas2);
	H.add(canvas1);

	int ranX = (int)random(width);
	int ranY = (int)random(height);

	int scale1 = 5+((int)random(5)*5);
	int scale2 = (scale1+10)+((int)random(10)*5);
	int scale3 = (scale2+20)+((int)random(5)*10);

	r1 = new HRect().rounding(5);
	r1
		.noStroke()
		.fill( colors.getColor() )
		.size( scale1 , scale1 )
		.loc( ranX , ranY )
		.anchorAt(H.CENTER)
		.rotation(45)
	;
	canvas1.add(r1);

	r2 = new HRect().rounding(5);
	r2
		.noStroke()
		.fill( colors.getColor() )
		.size( scale2 , scale2 )
		.loc( ranX , ranY )
		.anchorAt(H.CENTER)
		.rotation(45)
	;
	canvas2.add(r2);

	r3 = new HRect().rounding(5);
	r3
		.noStroke()
		.fill( colors.getColor() )
		.size( scale3 , scale3 )
		.loc( ranX , ranY )
		.anchorAt(H.CENTER)
		.rotation(45)
	;
	canvas3.add(r3);
}

void draw() {
	H.drawStage();

	int ranX = (int)random(width);
	int ranY = (int)random(height);

	int scale1 = 5+((int)random(5)*5);
	int scale2 = (scale1+10)+((int)random(10)*5);
	int scale3 = (scale2+20)+((int)random(5)*10);

	r1
		.fill( colors.getColor() )
		.size( scale1 , scale1 )
		.loc( ranX , ranY )
	;

	r2
		.fill( colors.getColor() )
		.size( scale2 , scale2 )
		.loc( ranX , ranY )
	;

	r3
		.fill( colors.getColor() )
		.size( scale3 , scale3 )
		.loc( ranX , ranY )
	;
}

