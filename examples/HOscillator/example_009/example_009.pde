HCanvas canvas;
HColorPool colors;

void setup() {
  size(640, 640);
  H.init(this).background(#111111);

  canvas = H.add(new HCanvas()).autoClear(true);

  colors = new HColorPool(
    #FFFFFF, #F7F7F7, #ECECEC, #FF3300,
    #FF3300, #242424, #333333, #666666);

  int starScale = 800;
  int starOffest = 15;
  for (int i=0; i<53; ++i) {
    HPath star1 = (HPath) canvas.add( new HPath().star(5, 0.5, -90) )
      .size(starScale)
      .noStroke()
      .fill( colors.getColor(i*250) )
      .anchorAt(H.CENTER)
      .locAt(H.CENTER);

    new HOscillator()
      .target(star1)
      .range(-20, 20)
      .speed(0.4).freq(8)
      .property(H.ROTATION)
      .currentStep(i);

    starScale -= starOffest;
  }
}

void draw() {
  H.drawStage();
}

