import hype.*;
import hype.extended.behavior.HFlowField;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HOscillator;
import hype.extended.behavior.HGradientCycle;

HDrawablePool   pool;
HFlowField      ff;
HCanvas         canvas;
HColorPool      colors;
HGradientCycle  gradient;
int             assets = 90;

void setup() {
  size(640,640,P2D);
  H.init(this).background(#242424);

  colors = new HColorPool(#F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);
  gradient = new HGradientCycle(colors);
  canvas = new HCanvas(P2D).fade(0);
  H.add(canvas);

  ff = new HFlowField()
  .debug(false)
  .resolution(16)
  .rotateTarget(true)
  .noise3D(true)
  .speedLow(1.5F)
  .speedHigh(2.82F);

  pool = new HDrawablePool(assets);
  
  pool.autoParent(canvas)
    .add(new HEllipse())
    .onCreate(
    new HCallback() {
    public void run(Object obj) {
      int i = pool.currentIndex()+1;
      HDrawable d = (HDrawable) obj;
      d.noStroke();
      d.size(1+((i*2)%5));
      d.loc((int)random(canvas.height()), (int) random(canvas.height()));
      ff.addParticle(d);
      gradient.addTarget(d).xStep(i*8).yStep(i*64).fillOnly();
    }
  }
  )
  .requestAll()
    ;
}

void draw() {
  H.drawStage();
}

 