import hype.*;
import hype.extended.behavior.HOrbiter;

void setup() {
  size(640,640,P3D);
  H.init(this).background(#242424).use3D(true);

  HRect d = new HRect(50).rounding(4);
  d.noStroke().fill(#FF3300).anchorAt(H.CENTER).rotation(45);
  H.add(d);

  HOrbiter orb = new HOrbiter(width/2, height/2)
    .target(d)
    .speed(1)
    .radius(250)
  ;
  
H.add(new HEllipse(200).loc(width/2,height/2).anchorAt(H.CENTER));
  
}

void draw() {
  H.drawStage();
}