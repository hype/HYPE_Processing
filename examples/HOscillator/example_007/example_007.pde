HDrawablePool pool;
HColorPool colors;

void setup() {
  size(640, 640);
  H.init(this).background(#202020);

  colors = new HColorPool(
    #FFFFFF, #F7F7F7, #ECECEC, #333333,
    #0095A8, #00616F, #FF3300, #FF6600);

  pool = new HDrawablePool(400);
  pool.autoAddToStage()
    .add( new HRect(50)
      .rounding(20)
      .noStroke()
      .anchorAt(H.CENTER) )
    .layout( new HGridLayout(400)
      .startLoc(0, height/2)
      .spacing(1, 0) )
    .onCreate( new HCallback() { public void run(Object obj) {
      int i = pool.currentIndex();
      
      HDrawable d = (HDrawable) obj;
      d.fill( colors.getColor(i*100) );
      
      new HOscillator()
        .target(d)
        .relativeVal( d.x() )
        .range(-300, 300)
        .freq(0.5)
        .property(H.X)
        .currentStep(i);
      new HOscillator()
        .target(d)
        .relativeVal( d.y() )
        .range(-300, 300)
        .speed(2)
        .freq(0.7)
        .property(H.Y)
        .currentStep(i);
      new HOscillator()
        .target(d)
        .range(0, 360)
        .speed(0.001)
        .property(H.ROTATION)
        .currentStep(i);
      new HOscillator()
        .target(d)
        .range(0, 2)
        .freq(4)
        .property(H.SCALE)
        .currentStep(i);
    }})
    .requestAll();
}

void draw() {
  H.drawStage();
}

