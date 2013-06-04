/*
 * This test file demonstrates the new feature
 * for transforming children whenever the parent
 * is resized.
 */

HGroup grp;
HRect r1, r2;

void setup() {
  size(600,600);
  H.init(this);
  
  /*
   * By default, most drawables by default won't transform
   * their children.
   */
  r1 = H.add(new HRect());
  r1.fill(H.RED);
  
  /*
   * To set it on, call transformsChildren(true).
   * To set it off, call transformsChildren(false).
   */
  r2 = H.add(new HRect());
  r2.fill(H.BLUE)
    .x(width/3)
    .transformsChildren(true);
  
  /*
   * The exception to this is HGroup, which is by default
   * would transform its children.
   *
   * You can turn this off with transformsChildren(false)
   */
  grp = H.add(new HGroup());
  grp.x(width*2/3);
  //grp.transformsChildren(false);
  
  
  H.add(new HText("transformsChildren(false)",12)).y(height-12);
  H.add(new HText("transformsChildren(true)",12)).loc(width/3,height-12);
  H.add(new HText("HGroup default",12)).loc(width*2/3,height-12);
  r1.add(new HEllipse(5));
  r1.add(new HEllipse(5)).locAt(H.TOP_RIGHT).anchorAt(H.TOP_RIGHT);
  r1.add(new HEllipse(5)).locAt(H.CENTER).anchorAt(H.CENTER);
  r1.add(new HEllipse(5)).locAt(H.BOTTOM_RIGHT).anchorAt(H.BOTTOM_RIGHT);
  r1.add(new HEllipse(5)).locAt(H.BOTTOM_LEFT).anchorAt(H.BOTTOM_LEFT);
  r2.add(new HEllipse(5));
  r2.add(new HEllipse(5)).locAt(H.TOP_RIGHT).anchorAt(H.TOP_RIGHT);
  r2.add(new HEllipse(5)).locAt(H.CENTER).anchorAt(H.CENTER);
  r2.add(new HEllipse(5)).locAt(H.BOTTOM_RIGHT).anchorAt(H.BOTTOM_RIGHT);
  r2.add(new HEllipse(5)).locAt(H.BOTTOM_LEFT).anchorAt(H.BOTTOM_LEFT);
  grp.add(new HEllipse(5));
  grp.add(new HEllipse(5)).locAt(H.TOP_RIGHT).anchorAt(H.TOP_RIGHT);
  grp.add(new HEllipse(5)).locAt(H.CENTER).anchorAt(H.CENTER);
  grp.add(new HEllipse(5)).locAt(H.BOTTOM_RIGHT).anchorAt(H.BOTTOM_RIGHT);
  grp.add(new HEllipse(5)).locAt(H.BOTTOM_LEFT).anchorAt(H.BOTTOM_LEFT);
}

void draw() {
  /*
   * I'm avoiding the width and height from being
   * set to 0, due to possible divide-by-zero errors
   *
   * I may get into fixing it some time later.
   */
  if(H.mouseStarted()) {
    float w = max(10, mouseX/3);
    float h = max(10, mouseY);
    r1.size(w,h);
    r2.size(w,h);
    grp.size(w,h);
  }
  H.drawStage();
}
