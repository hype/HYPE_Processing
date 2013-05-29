HShape s1,s2,s3,s4;
HColorPool colors;

void setup() {
  size(600,600);
  frameRate(6);
  H.init(this).background(64);
  
  colors = new HColorPool(
    0xFFFFFFFF, 0xFFF7F7F7, 0xFFECECEC, 0xFF333333,
    0xFF0095A8, 0xFF00616F, 0xFFFF3300, 0xFFFF6600);
  
  /*
   * randomColors() won't override the fill and stroke
   * anymore.
   */
  
  // Upper Left
  s1 = new HShape("bot1.svg");
  H.add(s1).scale(0.5f)
    .noStroke();
  
  // Center
  s2 = new HShape("bot1.svg");
  H.add(s2).scale(0.5f)
    .noFill()
    .anchorAt(H.CENTER).locAt(H.CENTER);
  
  // Bottom Right
  s3 = new HShape("bot1.svg");
  H.add(s3).scale(0.5f)
    .anchorAt(H.BOTTOM_RIGHT).locAt(H.BOTTOM_RIGHT);
  
  // Bottom Left
  s4 = new HShape("bot1.svg");
  H.add(s4).scale(0.5f)
    .stroke(H.MAGENTA)
    .anchorAt(H.BOTTOM_LEFT).locAt(H.BOTTOM_LEFT);
  
  
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
  colors.fillOnly();
  s4.randomColors(colors);
}
