HDrawable d;
float x,y,z;

void setup() {
  size(600,600,P3D);
  hint(DISABLE_DEPTH_TEST);
  H.init(this);
  
  x = random(600);
  y = random(600);
  z = random(-600);
  
  d = H.add(new HEllipse()).locAt(H.CENTER).anchorAt(H.CENTER).alpha(192);
  new HFollow().target(d);
}

/*
 * The circle and text stays at 2d screen space,
 * while the red box is randomly placed at 3d space.
 * 
 * If you try to move the circle to the center of the
 * red box, the circle will turn blue, even if the box
 * is in a different z level.
 */

void draw() {
  H.drawStage();
  
  fill(H.RED,64);
  pushMatrix();
  translate(x,y,z);
  rect(-50,-50,100,100);
  fill(H.WHITE,64);
  rect(-50,-50,50,50);
  rect(0,0,50,50);
  ellipse(0,0,10,10);
  fill(H.BLACK);
  popMatrix();
  
  /*
   * The key method here is `screenX()` and `screenY()`
   */
  float x2d = screenX(x,y,z);
  float y2d = screenY(x,y,z);
  text("This text is in 2d space", x2d, y2d);
  
  /*
   * HDrawable also uses screenX and screenY for its
   * `contains(x,y,z)` method.
   */
  boolean hit = d.contains(x,y,z);
  d.fill(hit? H.BLUE : H.WHITE);
  
  /*
   * `contains(x,y,z)` still assumes that the drawable
   * itself is at z = 0. I still have to test the algorithm
   * that I have for that.
   */
}
