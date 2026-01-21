import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

int numAssets = 15876;

HDrawable[] d = new HDrawable[numAssets];
HColorPool colors; 
HGridLayout layout;

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

    layout = new HGridLayout()
        .startX(5)
        .startY(5)
        .spacing(5,5)
        .cols(126)
    ;

    for (int i = 0; i < numAssets; ++i) {
        d[i]= new HRect(5);    
        d[i].noStroke();
        d[i].fill(  colors.getColor(i*3) );
        d[i].loc( layout.getNextPoint() );
        d[i].draw(this.g);
    }

noLoop();
}

void draw(){

}

