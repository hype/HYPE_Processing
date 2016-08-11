//Demonstrates how to use HGroupColorPool

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool pool;

HColorPool colors; 
HGroupColorPool grpColors;
HColorPool color1, color2, color3, color4, color5; 

void setup() {

	size(640,640);
	H.init(this).background(#202020);
	smooth();

	//create five color pools
	color1 = new HColorPool().add(#FFFFFF, 9).add(#ECECEC, 9).add(#CCCCCC, 9).add(#333333, 3).add(#0095a8, 2).add(#00616f, 2).add(#FF3300).add(#FF6600); 
	color2 = new HColorPool().add(#969696).add(#BD006B).add(#A3206A).add(#ECECEC);
	color3 = new HColorPool().add(#69B3C1).add(#55A1AF).add(#B6F2FC).add(#F9FAFB);
	color4 = new HColorPool().add(#E3EBEE).add(#C3C7CA).add(#323232).add(#A8A9AB).add(#FFFFFF).add(#626263).add(#777B7C).add(#949494).add(#4B4B4B).add(#D3D8DC).add(#B8B8B8);
	color5 = new HColorPool().add(#FAF814).add(#E7B427).add(#FFCE4D).add(#E38D38);

	//group all the color pools
	grpColors = new HGroupColorPool();
	grpColors.add(color1).add(color2).add(color3).add(color4).add(color5);

	runSketch();
	H.drawStage();
	
}

void runSketch() {

	//comment/uncomment the four lines below to try different options
	//colors = grpColors.getNextColorPool(); //cycle through available HColorPools in group - going forward
	//colors = grpColors.getPrevColorPool(); //cycle through available HColorPools in group - going backwards 
	colors = grpColors.getRandomColorPool(); //randomly select HColorPool
	//colors = grpColors.getColorPool(0);    //get specific HColorPool

	surface.setTitle("HGroupColorPool example: colorpool "+ (int)(grpColors.currentIndex()+1));

	pool = new HDrawablePool(81);
	pool.autoAddToStage();
	pool.add(new HEllipse().size(5+(int)random(2,4)*2));
	pool.add(new HEllipse().size(10+(int)random(4,6)*4));
	pool.add(new HEllipse().size(15+(int)random(7,8)*8));

	pool.layout (
		new HGridLayout()
			.startX(350)
			.startY(150)
			.spacing(80, 80)
			.cols(9)

		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;

					d
						.strokeWeight(0.25)
						.alpha(int(random(50,255)))
						.fill( colors.getColor() )
						.stroke( colors.getColor() )
						.loc( 100 + (int)random(width-200), 100 + (int)random(height-200) );
				}
			}
		)
		.requestAll();
}


void draw() {}

void keyPressed() {
	if (key == 'c') {
		resetColours(); //change colours from within the same HColorPool 
	}
	if (key == CODED) {
		if (keyCode == 40||keyCode == 34) {
			//go forward through HColorpools
			resetColourPool(1);
		} 
		if (keyCode == 33 || keyCode == 38) {
			//go backwards through HColorpools
			resetColourPool(-1);

		}
	}
}

void mousePressed() { 
	resetAll();
} 

void resetAll() {
	//reset all - e.g. layout + HColorPool 
	for (HDrawable d : pool) {
		H.remove(d);
	}
	runSketch();
	H.drawStage();
} 

void resetColours() { 
	for (HDrawable d : pool) {
		int c = colors.getColor();
		int s = colors.getColor();
		d.fill(c);
		d.stroke(s);
	}
	H.drawStage();
} 


void resetColourPool(int dir) { 
	if(dir>0){
		colors = grpColors.getNextColorPool();
	} else {
		colors = grpColors.getPrevColorPool();
	}
	surface.setTitle("HGroupColorPool example: colorpool "+ (int)(grpColors.currentIndex()+1));
	for (HDrawable d : pool) {
		int c = colors.getColor();
		int s = colors.getColor();
		d.fill(c);
		d.stroke(s);
	}
	H.drawStage();
} 
