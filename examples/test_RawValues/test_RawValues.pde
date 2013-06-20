HTween tween;
HOscillator osc;

void setup() {
  size(520,520);
  H.init(this);
  H.stage().showsFPS(true);
  
  tween = new HTween()
    .target(H.add(new HRect()).loc(width/3,height/2).anchorAt(H.CENTER_RIGHT))
    .property(H.SCALE)
    .ease(.1).spring(.9)
    .start(.5,1).end(1,.5);
  
  osc = new HOscillator()
    .target(H.add(new HRect()).loc(width*2/3,height/2).anchorAt(H.CENTER))
    .property(H.ROTATION)
    .range(-90,90);
}

void draw() {
  H.drawStage();
  
  /*
   * In order to get HTween, and HOscillator's
   * current value, we need to call any of the
   * following methods:
   *
   * - curr()  -- returns the first current value
   *              which is usually the current x or the current width
   * - curr1() -- also returns the first current value
   * - curr2() -- returns the second current value
   *              which is usually the current y or current height
   * - curr3() -- returns the third current value
   *              which is usually the current z
   */
  
  println("x scale: " + tween.curr1());
  println("y scale: " + tween.curr2());
  
  println("rotation: " + osc.curr());
  
  println("----");
  
  /*
   * You could also manually increment and get
   * the next raw values of HTween and HOscillator
   * via nextRaw()
   *
   * Remember that nextRaw() is called whenever
   * drawStage() is called, so the tweening or
   * oscillation may be affected when that method
   * is called
   */
  //tween.nextRaw(); // range: [0.0, 1.0]
  //osc.nextRaw(); // range: [-1.0, 1.0]
}
