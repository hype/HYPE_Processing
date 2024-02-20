import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HRotate;


int numAssets = 576;

HGridLayout layout;

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

    layout = new HGridLayout()
        .startX(32)
        .startY(32)
        .spacing(25,25)
        .cols(24)
    ;


    for (int i = 0; i < numAssets; ++i) {
        d[i]=new HRect(50).rounding(4);    
        d[i].noStroke().fill( colors.getColor() ).alpha( (int)random(50,200) );
        d[i].anchorAt( H.CENTER );
        d[i].loc( layout.getNextPoint() );

        rot[i] = new HRotate().speed(random(-2,2));
    }
}

void draw(){
    background(#242424);
    for (int i = 0; i < numAssets; ++i) {
        rot[i].run();
        d[i].rotation(rot[i].cur()).draw(this.g);
    }	
}