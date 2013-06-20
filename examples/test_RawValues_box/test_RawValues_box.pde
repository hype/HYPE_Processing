HOscillator zo;

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
		pt.z = (int)random(300) - 150;
		pickedLoc[i] = pt;
	}

	zo = new HOscillator()
		.range(-300,300)
		.speed(0.1)
		.freq(10)
	;
}

void draw() {
	background(#000000);
	noStroke();

	pointLight(255, 51, 0,  0, height/2, 0); // orange
	pointLight(0, 149, 168,  width, height/2, 0); // teal
	pointLight(255, 204, 0,  width/2, height/2, -100); // yellow

	zo.nextRaw();

	for (int i = 0; i<num; i++){
		PVector pt = pickedLoc[i];

		pushMatrix();
			translate( pt.x, pt.y, pt.z + zo.curr() );
			box( pickedSizes[i], pickedSizes[i], pickedSizes[i] );
		popMatrix();
	}

	H.drawStage();
}

