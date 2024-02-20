import hype.*;
import hype.extended.layout.HGridLayout;

int numAssets = 75;

HDrawable[] d = new HDrawable[numAssets];
HGridLayout layout;

void setup(){
    size(640,640,P3D);
    background(#242424);
    H.init(this).use3D(true);

    layout = new HGridLayout()
        .startX(120)
        .startY(120)
        .startZ(0)
        .spacing(100, 100, 50)
        .cols(5)
        .rows(5)
    ;

    for (int i = 0; i < numAssets; ++i){
        d[i] = new HBox().depth(50).width(50).height(50);
        d[i].loc( layout.getNextPoint() );  
        if (d[i].z() > 0)  d[i].fill(#FF6600);
        if (d[i].z() > 50) d[i].fill(#EEBB00);
    }
}

void draw(){
    background(#242424);
    lights();
    
    translate( width/2,  height/2);
    rotateY( map(mouseX, 0, width, -(TWO_PI/2), TWO_PI/2) );
    translate(-width/2, -height/2);

    for (int i = 0; i < numAssets; ++i){
        d[i].draw(this.g);
    }
}
