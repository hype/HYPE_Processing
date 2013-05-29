HCanvas canvas;
HDrawablePool pool;
HColorPool colors;

void setup() {
  size(640, 640, P3D);
  H.init(this).background(#202020).use3D(true);
  smooth();
  
  colors = new HColorPool(
    #FFFFFF, #F7F7F7, #ECECEC, #333333,
    #0095A8, #00616F, #FF3300, #FF6600)
    .fillOnly();
  
  canvas = new HCanvas(P3D).autoClear(false).fade(2);
  H.add(canvas);
  
  pool = new HDrawablePool(300);
  pool.autoParent(canvas)
    .add(new HRect().rounding(5))
    .colorist(colors)
    .onRequest(new HCallback(){public void run(Object obj) {
        final HDrawable d = (HDrawable) obj;
        d.noStroke()
          .size(HMath.randomInt(1,11)*5)
          .loc(random(width),random(height),random(-2000))
          .anchorAt(H.CENTER);

        int i = pool.currentIndex();
        
        final HOscillator rosc = new HOscillator().property(H.ROTATION)
          .target(d)
          .speed(1)
          .range(-90,90)
          .freq(2)
          .waveform(H.SINE)
          .currentStep(i*2);
        final HOscillator sosc = new HOscillator().property(H.SCALE)
          .target(d)
          .speed(0.5)
          .range(0,2)
          .freq(4)
          .waveform(H.SINE)
          .currentStep(i*2);
        new HTween().property(H.Z)
          .target(d)
          .ease(0.0005).spring(0.95)
          .start(d.z()).end(100)
          .callback(new HCallback(){public void run(Object obj) {
            rosc.unregister();
            sosc.unregister();
            pool.release(d);
          }});
    }});

  new HTimer(250).callback(new HCallback(){public void run(Object obj) {
    pool.request();
  }});
}

void draw() {
  H.drawStage();
}

