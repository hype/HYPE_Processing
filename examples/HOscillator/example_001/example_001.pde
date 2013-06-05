HDrawablePool pool;

void setup() {
  size(640, 640);
  H.init(this).background(#202020);

  pool = new HDrawablePool(90);
  pool.autoAddToStage()
    .add( new HRect(6)
      .rounding(2)
      .anchorAt(H.CENTER)
      .noStroke() )
    .colorist( new HColorPool(
      #FFFFFF, #F7F7F7, #ECECEC, #333333,
      #0095A8, #00616F, #FF3300, #FF6600)
      .fillOnly() )
    .layout( new HGridLayout(90)
      .startLoc(9, height/2)
      .spacing(7, 0))
    .onCreate( new HCallback() { public void run(Object obj) {
      HDrawable d = (HDrawable) obj;
      
      new HOscillator()
        .target(d)
        .freq(2)
        .relativeVal(320)
        .range(-100, 100)
        .currentStep( pool.currentIndex()*3 );
    }})
    .requestAll();
}

void draw() {
  H.drawStage();
}

