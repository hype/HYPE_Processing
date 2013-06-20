HOscillator l1,l2,l3,l4;

PVector[] pickedLoc; int[] pickedSizes; int num = 300;

void setup() {
	size(640,640, OPENGL);
	H.init(this).background(#000000).autoClear(false).use3D(true);
	smooth();

	pickedSizes = new int[num];
	pickedLoc = new PVector[num];

	for (int i = 0; i<num; i++){
		pickedSizes[i] = 5 + ((int)random(20)*5);

		PVector pt = new PVector();
		pt.x = (int)random(width);
		pt.y = (int)random(height);
		pt.z = (int)random(-300, 300);
		pickedLoc[i] = pt;
	}

	l1 = new HOscillator()
		.range(-300,300)
		.speed(0.1)
		.freq(6)
	;

	l2 = new HOscillator()
		.range(-300,300)
		.speed(0.12)
		.freq(9)
	;

	l3 = new HOscillator()
		.range(-300,300)
		.speed(0.14)
		.freq(12)
	;

	l4 = new HOscillator()
		.range(-300,300)
		.speed(0.16)
		.freq(15)
	;
}

void draw() {
	background(#000000);
	noStroke();

	l1.nextRaw();
	l2.nextRaw();
	l3.nextRaw();
	l4.nextRaw();

	pointLight(153, 0, 0,  100, height/2, l1.curr() ); // red
	pointLight(255, 102, 0,  width/2, 100, l2.curr() ); // orange
	pointLight(0, 153, 0,  width - 100, height/2, l3.curr() ); // green
	pointLight(0, 0, 153,  width/2, height-100, l4.curr() ); // blue

	for (int i = 0; i<num; i++){
		PVector pt = pickedLoc[i];

		pushMatrix();
			translate( pt.x, pt.y, pt.z );
			// translate( pt.x, pt.y, pt.z + map(l3.curr(), -300, 300, -300, 100) );

			// rotateX(map(l1.curr(), -300, 300, 0, PI));
			// rotateY(map(l2.curr(), -300, 300, 0, PI));
			// rotateZ(map(l3.curr(), -300, 300, 0, PI));

			box( pickedSizes[i], pickedSizes[i], pickedSizes[i] );
		popMatrix();
	}

	H.drawStage();
}

