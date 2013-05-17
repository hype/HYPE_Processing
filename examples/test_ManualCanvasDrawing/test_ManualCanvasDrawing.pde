HCanvas canvas1, canvas2;
HGroup group1;
float rot;

void setup() {
  size(512,512,P3D);
  H.init(this).use3D(true);
  
  canvas1 = new HCanvas(P3D).fade(10);
  canvas2 = new HCanvas().renderer(P3D);
  
  // HGroup is like canvas but much simpler and faster, and without PGraphics
  group1 = new HGroup();
  HDrawable tmp = group1.add(new HEllipse()).anchorAt(H.CENTER);
  new HFollow().target(tmp);
  
  
  H.add(canvas1);
  H.add(group1);
  H.add(canvas2);
}

void draw() {
  // Manual drawing for canvas 1
  PGraphics g1 = canvas1.graphics();
  
  g1.beginDraw(); //g1.clear();
    g1.translate(width/2,height/2);
    g1.rotateY(radians(rot++));
    g1.fill(#FF0000);
    g1.beginShape(QUAD_STRIP);
      g1.vertex(-100,100,-100);
      g1.vertex(100,100,-100);
      g1.vertex(-100,-100,-100);
      g1.vertex(100,-100,-100);
      
      g1.vertex(-100,-100,100);
      g1.vertex(100,-100,100);
    g1.endShape();
  g1.endDraw();
  
  // Manual drawing for canvas 2
  PGraphics g2 = canvas2.graphics();
  
  g2.beginDraw(); g2.clear();
    g2.translate(width/2,height/2,-150);
    g2.rotateX(radians(rot));
    g2.sphere(100);
  g2.endDraw();
  
  H.drawStage();
}
