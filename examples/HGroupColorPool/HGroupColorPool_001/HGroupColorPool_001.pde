import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.colorist.HGroupColorPool;

HDrawablePool   pool;
HColorPool      colors; 
HColorPool      color1, color2, color3; 
HGroupColorPool grpColors;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	color1 = new HColorPool().add(#FF3300).add(#FF6600).add(#FF9900).add(#FFFFFF);
	color2 = new HColorPool().add(#33FF00).add(#66FF00).add(#99FF00).add(#FFFFFF);
	color3 = new HColorPool().add(#0033FF).add(#0066FF).add(#0099FF).add(#FFFFFF);

	// group all the HColorPool's

	grpColors = new HGroupColorPool();
	grpColors.add(color1).add(color2).add(color3);

	runSketch();
	H.drawStage();
}

void draw() {}

void keyPressed() {
	// if (key == CODED) {
	// 	if (keyCode == 39) {
	// 		colors = grpColors.getNextColorPool(); // "R Arrow" = go forward through HColorpools
	// 		resetColours();
	// 	}
	// 	if (keyCode == 37) {
	// 		colors = grpColors.getPrevColorPool(); // "L Arrow" = go backwards through HColorpools
	// 		resetColours();
	// 	}
	// }

	switch (key) {
		case 'c': resetColours(); break;

		case '1': colors = grpColors.getColorPool(0); break;
		case '2': colors = grpColors.getColorPool(1); break;
		case '3': colors = grpColors.getColorPool(2); break;

		// case UP :
		// 	println("UP");
		// break;
	}
}

void mousePressed() { 
	resetAll();
} 

void runSketch() {
	colors = grpColors.getNextColorPool();     // cycle through available HColorPools in group - going forward
	//colors = grpColors.getPrevColorPool();   // cycle through available HColorPools in group - going backwards 
	//colors = grpColors.getRandomColorPool(); // randomly select HColorPool
	//colors = grpColors.getColorPool(0);      // get specific HColorPool

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HEllipse())
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(colors.getColor(), (int)random(50,255)).anchorAt(H.CENTER).loc( (int)random(width), (int)random(height) );
				}
			}
		)
		.requestAll()
	;
}

void resetColours() { 
	for (HDrawable d : pool) {
		d.fill(colors.getColor(), (int)random(50,255));
	}
	H.drawStage();
} 

void resetAll() {
	// reset all - e.g. layout + HColorPool 
	for (HDrawable d : pool) {
		H.remove(d);
	}
	runSketch();
	H.drawStage();
} 
