import hype.*;
import hype.extended.behavior.HOrbiter;
import hype.extended.colorist.HColorPool;

HDrawablePool pool;

void setup() {
  size(640,640,P2D);
  H.init(this).background(#242424).use3D(false);

  pool = new HDrawablePool(42);
  pool.autoAddToStage()
    .add(new HRect(50).rounding(10))
    .colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly() )
    .onCreate(
      new HCallback() {
        public void run(Object obj) {
          HDrawable d = (HDrawable) obj;
          d.noStroke().anchorAt(H.CENTER).rotation(45);

          HOrbiter orb = new HOrbiter(width/2, height/2)
            .target(d)
            .speed(random(-1.5, 1.5))
            .radius(250)
            .startAngle( (int)random(360) )
          ;
        }
      }
    )
    .requestAll()
  ;
  
H.add(new HEllipse(200).loc(width/2,height/2).anchorAt(H.CENTER));
  
}

void draw() {
  H.drawStage();
}