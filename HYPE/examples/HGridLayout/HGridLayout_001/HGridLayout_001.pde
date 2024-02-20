import hype.*;
import hype.extended.layout.HGridLayout;

int numAssets = 576;  

HGridLayout layout;
HRect[] d = new HRect[numAssets];

void setup(){
    size(640,640);
    background(#242424);
    H.init(this);

    layout = new HGridLayout()
        .startX(21)
        .startY(21)
        .spacing(26,26)
        .cols(24);
    
    for (int i = 0; i < numAssets; ++i){
        d[i] = new HRect(25).rounding(4);
        d[i].noStroke().fill(#ECECEC).anchorAt(H.CENTER);
        d[i].loc( layout.getNextPoint() );  
    }
}

void draw(){
    background(#242424);
    for (int i = 0; i < numAssets; ++i){
        d[i].draw(this.g);
    }
}