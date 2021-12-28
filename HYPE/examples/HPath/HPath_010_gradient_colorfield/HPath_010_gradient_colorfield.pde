import hype.*; 
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool     pool;
HCanvas           canvas;
int               numAssets = 7;
HColorField       colorField;

void setup() {
  size(640, 640, P3D);
  H.init(this).background(#333333).use3D(true).autoClear(true);
  smooth(8);

  colorField = new HColorField(width, height)
    .addPoint(100, 100, H.RED, 0.65)
    .addPoint(width-50, height-50, H.GREEN, 0.7)
    .addPoint(random(width), random(height), H.YELLOW, 0.4)
    .fillOnly()
    ;

  pool = new HDrawablePool(numAssets);
  canvas = new HCanvas(P3D).autoClear(false).fade(1);
  H.add(canvas);

  pool.autoParent(canvas)
    .add (
    new HPath().polygon(5, (int)random(0, 4)*90)
    )
    .add (
    new HPath().polygon(6, (int)random(0, 4)*90)
    )
    .add (
    new HPath().polygon(3, (int)random(0, 4)*90)
    )
    .layout(
    new HGridLayout().spacing(80, 80).cols(20)
    )
    .onCreate(
    new HCallback() {
    public void run(Object obj) {
      HPath d = (HPath) obj;
      d.vertexColors(colorField);
      d.size(120);
      d.fill(#333333);
      d.noStroke();
      d.anchorAt(CENTER);

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
        .currentStep( pool.currentIndex()%3 )
        ;

      new HOscillator()
        .target(d)
        .property(H.SCALE)
        .range(0.8, 1.1)
        .speed(0.6)
        .freq(2)
        .currentStep( pool.currentIndex()%(int)random(4, 7) )
        ;
    }
  }
  )
  .requestAll();
}

void draw() {

  for (HDrawable d : pool) {
    d.loc(mouseX, mouseY);
  }

  H.drawStage();
}
