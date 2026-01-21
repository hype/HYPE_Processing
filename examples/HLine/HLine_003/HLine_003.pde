import hype.*;
import hype.extended.layout.HSphereLayout;
import hype.extended.colorist.HColorPool;

HSphereLayout layout;
HColorPool colors;

void setup() {
  size(640, 640, P3D); 
  H.init(this).background(#242424).use3D(true);

  layout = new HSphereLayout().loc(width/2, height/2, 0).radius(200).rotate(true);
  layout.useProportional().detail(13);
  
  colors = new HColorPool().add(H.RED).add(H.GREEN);

  H.add(new HSphere().size(50).loc(width/2, height/2, 0).anchorAt(H.CENTER));

  for (int i=0; i<320; i++) {
    PVector loc = layout.getNextPoint();
    HLine line = new HLine(width/2, height/2, 0, loc.x, loc.y, loc.z);
    line.stroke(H.WHITE);
    line.strokeWeight(i%3.0F);
    line.gradient(colors);
    H.add(line);
  }
}

void draw() {
  if (mousePressed) {
    translate(width/2, height/2);
    rotateX(map(mouseY, 0, height, -(TWO_PI/2), TWO_PI/2));
    rotateY(map(mouseX, 0, width, -(TWO_PI/2), TWO_PI/2));
    translate(-width/2, -height/2);
  }

  lights();
  H.drawStage();
}