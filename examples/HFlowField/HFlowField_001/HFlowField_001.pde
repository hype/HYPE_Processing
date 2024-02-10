import hype.*;
import hype.extended.behavior.HFlowField;
import hype.extended.colorist.HColorPool;

HDrawablePool  pool;
HFlowField     ff;
HCanvas        canvas;
HColorPool     colors;
int            assets = 10;

void setup() {
  size(640, 640, P2D);
  H.init(this).background(#202020).use3D(false);

  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

  canvas = new HCanvas(P2D);
  H.add(canvas);

  ff = new HFlowField()
  .debug(true)
  .resolution(30)
  .rotateTarget(true)
  ;

  pool = new HDrawablePool(assets)
  .autoParent(canvas)
    .add(new HRect(5,25).rounding(4))
    .onCreate(
    new HCallback() {
    public void run(Object obj) {
      HDrawable d = (HDrawable) obj;
      d.fill( colors.getColor());
      d.noStroke();
      d.anchorAt(H.CENTER);
      d.loc((int) random(canvas.width()), (int) random(canvas.height()));
      ff.addParticle(d);
    }
  }
  )
  .requestAll()
    ;
}


void draw() {
  H.drawStage();
}