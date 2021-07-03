//press the mouse...
import hype.*;
import hype.extended.behavior.HFlowField;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HOscillator;

HDrawablePool  pool;
HFlowField     ff;
HCanvas        canvas;
HColorPool     colors;
int            assets = 100;
boolean        show=true;

void setup() {
  size(640, 640, P2D);
  H.init(this).background(#202020);

  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

  canvas = new HCanvas(P2D).fade(0);
  H.add(canvas);

  ff = new HFlowField()
  .debug(show)
  .resolution(8)
  .rotateTarget(true)
  .noise3D(true)
  .forceLow(9.5F)
  .forceHigh(12.9F)
  .speedLow(1.5F)
  .speedHigh(2.82F);

  pool = new HDrawablePool(assets);
  pool.autoParent(canvas)
    .add(new HEllipse())
    .onCreate(
    new HCallback() {
    public void run(Object obj) {
      int i = pool.currentIndex();
      HDrawable d = (HDrawable) obj;
      d.fill( colors.getColor());
      d.noStroke();
      d.anchorAt(H.CENTER);
      d.size((i*3)%5);
      d.loc((int) random(canvas.width()), (int) random(canvas.height()));
      ff.addParticle(d);
      new HOscillator().target(d).property(H.SCALE).waveform(H.SINE).speed(2).freq(.7F).range(-1,6).currentStep(i*3);
    }
  }
  )
  .requestAll()
    ;
}

void draw() {
  H.drawStage();
}

void mouseClicked() {
  show = ! show;
  ff.debug(show);
} 
  
 