import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HOscillator;

int numAssets = 125;

HBox[] d = new HBox[numAssets];
HGridLayout layout;

HOscillator osc;

float scale = 0;
float r = 0;

void setup(){
    size(640,640,P3D);
    background(#242424);
    H.init(this).use3D(true);

    osc = new HOscillator().range(0.2, 2.5).speed(10).freq(2);

    layout = new HGridLayout().startX(180).startY(180).startZ(-140).spacing(70, 70, 70).cols(5).rows(5);

    for (int i = 0; i < numAssets; ++i){
        d[i] = new HBox().depth(25);
        d[i].width(25).height(25);
        d[i].loc( layout.getNextPoint() );  
    }
}

void draw(){
    background(#242424);
    lights();
    
    translate( width/2,  height/2);
    rotateY( radians(r) );
    translate(-width/2, -height/2);
    r += 0.3;

    for (int i = 0; i < numAssets; ++i){
        osc.currentStep(frameCount + i *3).nextRaw();
        scale = osc.curr();

        HBox b = (HBox) d[i];
        b.depth(25 * scale);
        b.width(25 * scale).height(25 * scale);
        b.draw(this.g);
    }
}
