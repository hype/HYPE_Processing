import hype.*;
import hype.extended.layout.HCircleLayout;

import hype.extended.behavior.HOscillator;

int assets =    2880;
HCircleLayout   circle;
HDrawablePool   pool;

void setup() {
  size(640, 640, P3D);
  H.init(this).background(#242424).use3D(true);

  circle = new HCircleLayout()
    .startLoc(width/2, height/2).radius(150).angleStep((float)22*360/assets)
    .useNoise(true)
    .rotateTarget(true)
    .noiseRadius(100);

  pool = new HDrawablePool(assets);
  pool.autoAddToStage()
    .add(new HRect(2, 2).noStroke().fill(#FF3300).anchorAt(H.CENTER))
    .layout(circle)
        .onCreate(
      new HCallback() {
        public void run(Object obj) {
          int i = pool.currentIndex();
          HDrawable d = (HDrawable) obj;
                    new HOscillator()
            .target(d)
            .property(H.Z)
            .relativeVal(d.z())
            .range(-120, 120)
            .speed(2.3)
            .freq(1.5)
            .currentStep(i%360)
            .waveform(H.EASE)
          ;
          
        }
      }
      )
    .requestAll()
    ;



  //outline to show min/max noise bounds
  float x = circle.startX();
  float y = circle.startY();
  //H.add(new HEllipse(circle.minRadius()).noFill().loc(x, y).anchorAt(H.CENTER));
  //H.add(new HEllipse(circle.maxRadius()).noFill().loc(x, y).anchorAt(H.CENTER));

  //map dark/light colors according to min/max noise radisu
  for (HDrawable d : pool) {
    float len = dist(d.x(), d.y(), x, y);
    int clr = (int)map(len, circle.minRadius(), circle.maxRadius(), 0, 255);
    d.fill(clr, clr);
  }

  
}

void draw() {
  H.drawStage();
}