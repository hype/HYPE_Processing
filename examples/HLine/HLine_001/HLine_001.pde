import hype.*;

HDrawablePool pool;

void setup() {
  size(640,640);
  H.init(this).background(#242424);

  pool = new HDrawablePool(100);
  pool.autoAddToStage()
    .add(new HLine(0, 0, 0,20))
    .onCreate(
      new HCallback() {
        public void run(Object obj) {
          HLine d = (HLine) obj;
          d
            .position(width/2,height/2,(int)random(width), (int)random(height))
            .strokeWeight(1)
            .stroke(#999999)
          ;
        }
      }
    )
    .requestAll()
  ;

  H.drawStage();
  noLoop();
}

void draw() {
}