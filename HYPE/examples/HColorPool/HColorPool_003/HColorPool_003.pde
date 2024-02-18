import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HRotate;


int numAssets = 100;

HRotate[] rot = new HRotate[numAssets];
HDrawable[] d = new HDrawable[numAssets];
HColorPool colors; 
// **************************************************

void setup(){
    size(640,640);
    background(#242424);
    H.init(this);

// add a higher probability of white & grey by inserting more entries into the pool
    	colors = new HColorPool()
		.add(#FFFFFF, 9)
		.add(#ECECEC, 9)
		.add(#CCCCCC, 9)
		.add(#333333, 3)
		.add(#0095a8, 2)
		.add(#00616f, 2)
		.add(#FF3300)
		.add(#FF6600)
	;
    for (int i = 0; i < numAssets; ++i) {
        d[i]=(i%2==0) ? new HRect().rounding(10): new HEllipse();    
        d[i].stroke(colors.getColor(), 150);
        d[i].fill(  colors.getColor(), 50 );
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
        d[i].rotation(rot[i].cur()).draw(this.g);
    }	
}

