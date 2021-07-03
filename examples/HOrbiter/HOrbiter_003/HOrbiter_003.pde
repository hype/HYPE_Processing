//somewhat spirograph-y fun
import hype.*;
import hype.extended.behavior.HOrbiter;

HOrbiter   orb1, orb2, orb3, orb4;
HCanvas    canvas;

void setup() {
  size(640, 640, P2D);
  H.init(this).background(#242424);

  canvas = new HCanvas().autoClear(false);
  H.add(canvas);

  HEllipse d = new HEllipse(1);
  d.noStroke().fill(H.WHITE).anchorAt(H.CENTER);
  canvas.add(d);

  orb1 = new HOrbiter(width/2, height/2)
    .speed(1)
    .radius(125)
    ;

  orb2 = new HOrbiter(width/2, height/2)
    .speed(2.5)
    .radius(random(2, width/7.4))
    .parent(orb1)
    ;

  orb3 = new HOrbiter(width/2, height/2)
    .speed(.9)
    .radius(random(2, (width*2)/21.4))
    .parent(orb2)
    ;

  orb4 = new HOrbiter(width/2, height/2)
    .target(d)
    .speed(3.12)
    .radius(random(2, (width/2)/10.7))
    .parent(orb2)
    ;

  //radius values  
  println(orb2.radius());
  println(orb3.radius());
  println(orb4.radius());
}

void draw() {
  H.drawStage();
}