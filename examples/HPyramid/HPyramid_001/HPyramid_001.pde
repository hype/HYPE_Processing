import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawable   pyramid;
HOscillator o, o2;

void setup() {
  size(640, 640, P3D); 
  H.init(this).background(#202020).use3D(true);
  smooth();
  frameRate(16);

  hint(ENABLE_DEPTH_SORT); //you'll need this otherwise setting alpha on HPyramid gets...nasty...

  pyramid = new HPyramid().loc(width/2, height/2); 
  H.add(pyramid);

  o = new HOscillator().waveform(H.SINE).speed(1).freq(2);
  o2 = new HOscillator().waveform(H.SINE).speed(0.6).freq(4);
}

void draw() {
  ambientLight(127, 127, 127); //setup some lights

  //do things with the pyramid...like changing it into a cylinder...
  HPyramid d = (HPyramid) pyramid; //need to cast to HPyramid to acccess custom methods
  d.rotateX(-3).rotateY(-2.7).rotateZ(-4); // let's spin around
  d.sides((int)map(o2.nextRaw(), -1, 1, 4, 50)); // change the number of sides
  d.topRadius((int)map(o2.nextRaw(), -1, 1, 0, 100)); // zero gives a pyramid. Higher values to create cone/cylinder
  d.height((int)map(o2.nextRaw(), -1, 1, 125, 250)); // change the height 
  d.stroke(#202020);
  d.strokeWeight(1);
  d.fill(H.ORANGERED, 255);

  H.drawStage(); //draw updates
} 
