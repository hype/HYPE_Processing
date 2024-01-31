import hype.*; 
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool     pool;
HCanvas           canvas;
HImage            i1;
int               numAssets = 240;

void setup() {
  size(640, 640, P3D);
  H.init(this).background(#202020).use3D(true).autoClear(true);
  smooth();

  pool = new HDrawablePool(numAssets);

  canvas = new HCanvas(P3D).autoClear(false).fade(21);
  H.add(canvas);
  i1 = new HImage("tex1.jpg");

  pool.autoParent(canvas)
    .add (
    new HPath().polygon(3, (int)random(0, 4)*90).size(10*(int)random(10, 15))
    )
    .layout(
    new HGridLayout().spacing(80, 80).cols(20)
    )
    .onCreate(
    new HCallback() {
    public void run(Object obj) {
      HPath d = (HPath) obj;
      d.texture(i1);
      d.fill((int)random(127,255),(int)random(127),0);
      d.anchorAt(CENTER);

      new HOscillator()
        .target(d)
        .property(H.Y)
        .relativeVal(d.y())
        .range(0, -height/2)
        .speed(0.3)
        .freq(3)
        .waveform(H.SINE)
        .currentStep( pool.currentIndex()%3 )
        ;

      new HOscillator()
        .target(d)
        .property(H.X)
        .relativeVal(d.x())
        .range(-250, 250)
        .speed(0.3)
        .freq(1)
        .waveform(H.SAW)
        .currentStep( pool.currentIndex()*3 )
        ;

      new HOscillator()
        .target(d)
        .property(H.ROTATIONX) 
        .range(-360, 360)
        .speed(0.3)
        .freq(3)
        .waveform(H.SINE)
        .currentStep( pool.currentIndex()%3 )
        ;

      new HOscillator()
        .target(d)
        .property(H.ROTATIONZ) 
        .range(-720, 720)
        .speed(0.3)
        .freq(3)
        .waveform(H.SINE)
        .currentStep( pool.currentIndex()%13 )
        ;

      new HOscillator()
        .target(d)
        .property(H.SCALE)
        .range(0.8, 1.1)
        .speed(0.6)
        .freq(2)
        .currentStep( pool.currentIndex()%(int)random(4, 7) )
        ;

      new HOscillator()
        .target(d)
        .property(H.Z)
        .range(0, 300)
        .speed(0.16)
        .freq(2.3)
        .currentStep( pool.currentIndex()%2)
        ;
    }
  }
  )
  .requestAll()
    ;
}

void draw() {
  H.drawStage();
}
