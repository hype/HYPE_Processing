HDrawablePool pool;
HCanvas canvas;
HColorPool colors;

void setup() {
  size(640, 640);
  H.init(this).background(#111111);
  
  colors = new HColorPool(
    #CCE70B, #80C41C, #40A629, #237D26,
    #FF3300, #FF6600, #0095a8, #00616f);

  canvas = H.add( new HCanvas() )
    .autoClear(false)
    .fade(10);
  
  pool = new HDrawablePool(400);
  pool.autoParent(canvas)
    .add( new HPath()
      .star(5, 0.4, -90)
      .size(75)
      .noStroke()
      .anchor(0, 75) )
    .layout( new HGridLayout(400)
      .startLoc(0, height/2)
      .spacing(2, 0) )
    .onCreate( new HCallback() { public void run(Object obj) {
      int i = pool.currentIndex();

      HPath d = (HPath) obj;
      d.fill( colors.getColor(i*100), 3 );
      
      new HOscillator()
        .target(d)
        .speed(0.3)
        .freq(0.5)
        .relativeVal(d.x())
        .range(-600, 300)
        .property(H.X)
        .currentStep(i);
      new HOscillator()
        .target(d)
        .speed(0.2)
        .relativeVal(d.y())
        .range(-300, 300)
        .freq(0.7)
        .property(H.Y)
        .currentStep(i);
      new HOscillator()
        .target(d)
        .speed(0.7)
        .range(0, 360)
        .freq(2)
        .property(H.ROTATION)
        .currentStep(i);
      new HOscillator()
        .target(d)
        .speed(0.3)
        .range(0.5, 4)
        .freq(5)
        .property(H.SCALE)
        .currentStep(i);
    }})
    .requestAll();
}

void draw() {
  H.drawStage();
}

