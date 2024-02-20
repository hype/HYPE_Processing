import hype.*;
import hype.extended.layout.HGridLayout;

int numAssets = 125;

HDrawable[] d = new HDrawable[numAssets];
HGridLayout layout;

void setup(){
    size(640,640,P3D);
    background(#242424);
    H.init(this).use3D(true);

    layout = new HGridLayout()
        .startX(180)
        .startY(180)
        .startZ(-140)
        .spacing(70, 70, 70)
        .cols(5)
        .rows(5)
    ;

    for (int i = 0; i < numAssets; ++i){
        d[i] = new HBox().depth(25).width(25).height(25);
        d[i].loc( layout.getNextPoint() );  
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
