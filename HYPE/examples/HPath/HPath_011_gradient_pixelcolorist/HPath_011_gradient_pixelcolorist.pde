import hype.*; 
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool     pool;
HCanvas           canvas;
int               numAssets = 25;
HPixelColorist    colors;

void setup() {
  size(640, 640, P3D);
  H.init(this).background(#333333).use3D(true).autoClear(true);
  smooth(8);

  colors = new HPixelColorist("color.jpg").fillOnly();

  canvas = new HCanvas(P3D).autoClear(false).fade(24);
  H.add(canvas);

  HDrawable tri = new HPath().polygon(3).vertexColors(colors).size(410).anchorAt(H.CENTER).loc(width/2, height/2);
  canvas.add (tri);
  tri.z(100);
  tri.noStroke();
  HRotate rot1 = new HRotate();
  rot1.target(tri).speed(2.75);

  new HOscillator()
    .target(tri)
    .property(H.SCALE)
    .range(0.2, 1.2)
    .speed(2.75)
    .freq(0.4)
    ;

  new HOscillator()
    .target(tri)
    .property(H.Y)
    .relativeVal(tri.y())
    .range(30, -30)
    .speed(2.75)
    .freq(0.4)
    ;

  new HOscillator()
    .target(tri)
    .property(H.X)
    .relativeVal(tri.x())
    .range(30, -30)
    .speed(2.75)
    .freq(0.4)
    ;
}

void draw() {
  H.drawStage();
} 
