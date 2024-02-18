import hype.*;
import hype.extended.colorist.HColorPool;

int rows = 126;
int numAssets = (rows * rows);

HDrawable[] d = new HDrawable[numAssets];
HColorPool colors; 
// **************************************************

void setup(){
    size(640,640);
    background(#242424);
    H.init(this);

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
    for (int x = 0; x < rows; ++x) {
        for (int y = 0; y < rows; ++y) {
            d[x*y]= new HRect(5);    
            d[x*y].noStroke();
            d[x*y].fill(  colors.getColorAt( (x + y * (int)random(3) )%colors.size()) );
            d[x*y].loc( 5 + (x*5), 5 + (y*5) );
            d[x*y].draw(this.g);
        }
    }
noLoop();
}

void draw(){

}

