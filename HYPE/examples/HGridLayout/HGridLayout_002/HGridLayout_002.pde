import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

int numAssets = 576;  

HGridLayout layout;
HColorPool  colors;

HRect[] d = new HRect[numAssets];

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
        .startX(21)
        .startY(21)
        .spacing(26,26)
        .cols(24);
    
    for (int i = 0; i < numAssets; ++i){
        d[i] = new HRect(36).rounding(4);
        d[i].noStroke().fill(colors.getColor()).anchorAt(H.CENTER).rotation(45);
        d[i].loc( layout.getNextPoint() );  
    }
}

void draw(){
    background(#242424);
    for (int i = 0; i < numAssets; ++i){
        d[i].draw(this.g);
    }
}