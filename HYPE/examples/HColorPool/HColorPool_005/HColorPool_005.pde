import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HRotate;


int numAssets = 200;


HRotate[] rot = new HRotate[numAssets];
HDrawable[] d = new HDrawable[numAssets];

HColorPool colors; 
int colorIndex = 0;
// **************************************************

void setup(){
    size(640,640);
    background(#242424);
    H.init(this);

	colors = new HColorPool(#FFFFFF, #333333, #0095a8, #FF3300);

    for (int i = 0; i < numAssets; ++i) {
        d[i]=(i%2==0) ? new HRect().rounding(10): new HEllipse();    
        d[i].noStroke();
        d[i].fill(  colors.getColorAt(colorIndex) );
        d[i].loc( (int)random(width), (int)random(height) );
        d[i].anchor( new PVector(25,25) );
        d[i].size( 25+((int)random(3)*25) );

        rot[i] = new HRotate().speed(random(-4,4));
    }
}

void draw(){
    background(#242424);
    for (int i = 0; i < numAssets; ++i) {
        rot[i].run();
        d[i].fill( colors.getColorAt(colorIndex) );
        d[i].rotation(rot[i].cur()).draw(this.g);
    }	
}

void keyPressed() {
	switch (key) {
		case ' ':
			colorIndex = ++colorIndex%colors.size(); // press the spacebar on your keyboard to cycle through the colors
		break;
	}
}
