HShape s1,s2,s3,s4;
HColorPool colors;

void setup() {
  size(600,600);
  frameRate(6);
  H.init(this).background(64);
  
  /*
   * HShape no longer contains its own HColorPool.
   * Instead, it fetches colors from the passed color
   * pool, then stores it as a static int array.
   * 
   * This way, the colors stay the same, unitl you
   * set them again.
   */
  
  colors = new HColorPool(
    0xFFFFFFFF, 0xFFF7F7F7, 0xFFECECEC, 0xFF333333,
    0xFF0095A8, 0xFF00616F, 0xFFFF3300, 0xFFFF6600);
  
  // Upper Left
  s1 = new HShape("bot1.svg");
  H.add(s1).scale(0.5f);
  
  // Center
  s2 = new HShape("bot1.svg");
  H.add(s2).scale(0.5f).anchorAt(H.CENTER).locAt(H.CENTER);
  
  // Bottom Right
  s3 = new HShape("bot1.svg");
  H.add(s3).scale(0.5f).anchorAt(H.BOTTOM_RIGHT).locAt(H.BOTTOM_RIGHT);
  
  // Bottom Left
  s4 = new HShape("bot1.svg");
  H.add(s4).scale(0.5f).anchorAt(H.BOTTOM_LEFT).locAt(H.BOTTOM_LEFT);
  
  /*
   * s1, s2 and s3 will now only change their colors when
   * randomColors() is called.
   *
   * We no longer need to create copies of the color pool
   * for multiple HShapes.
   */
  
  colors.fillOnly();
  s1.randomColors(colors);
  
  colors.strokeOnly();
  s2.randomColors(colors);
  
  colors.fillAndStroke();
  s3.randomColors(colors);
}

void draw() {
  H.drawStage();
  
  // Change s4's colors at every frame
  s4.randomColors(colors);
}
