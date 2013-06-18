HRect boundingBox, rect;

void setup() {
  size(640,640);
  H.init(this).background(64);
  
  H.add(boundingBox = new HRect())
    .noFill().stroke(H.YELLOW)
    .strokeWeight(2);
  
  H.add(rect = new HRect())
    .anchorUV(random(1),random(1))
    .size(random(50,100),random(50,100))
    .locAt(H.CENTER);
  
  new HRotate().target(rect).speed(1);
  new HFollow().target(rect);
}

void draw() {
  // `rect.bounds()` will set the x & y fields of `loc` and `size`
  PVector loc = new PVector(), size = new PVector();
  rect.bounds(loc,size);
  boundingBox.loc(loc.x,loc.y).size(size.x,size.y);
  
  H.drawStage();
}
