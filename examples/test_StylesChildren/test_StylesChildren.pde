/*
 * This test file demonstrates the recently
 * added feature for styling the children
 * of HDrawable objects.
 */

void setup() {
  size(600, 600);
  H.init(this);
  
  HDrawable p = new HPath().vertexUV(0,0).vertexUV(0,1).vertexUV(1,0).vertexUV(1,1).size(50);
  
  HDrawable d1 = H.add(new HEllipse(25)).loc(width/2-170,height/2).anchorAt(H.CENTER);
  d1.add(p.createCopy()).anchorAt(H.BOTTOM_RIGHT).locAt(H.TOP_LEFT);
  d1.add(p.createCopy()).anchorAt(H.BOTTOM_LEFT).locAt(H.TOP_RIGHT);
  d1.add(p.createCopy()).anchorAt(H.TOP_LEFT).locAt(H.BOTTOM_RIGHT);
  d1.add(p.createCopy()).anchorAt(H.TOP_RIGHT).locAt(H.BOTTOM_LEFT);

  HDrawable d2 = H.add(new HEllipse(25)).locAt(H.CENTER).anchorAt(H.CENTER);
  d2.add(p.createCopy()).anchorAt(H.BOTTOM_RIGHT).locAt(H.TOP_LEFT);
  d2.add(p.createCopy()).anchorAt(H.BOTTOM_LEFT).locAt(H.TOP_RIGHT);
  d2.add(p.createCopy()).anchorAt(H.TOP_LEFT).locAt(H.BOTTOM_RIGHT);
  d2.add(p.createCopy()).anchorAt(H.TOP_RIGHT).locAt(H.BOTTOM_LEFT);
  
  HDrawable grp = H.add(new HGroup()).size(50).loc(width/2+170,height/2).anchorAt(H.CENTER);
  grp.add(p.createCopy()).anchorAt(H.BOTTOM_RIGHT).locAt(H.TOP_LEFT);
  grp.add(p.createCopy()).anchorAt(H.BOTTOM_LEFT).locAt(H.TOP_RIGHT);
  grp.add(p.createCopy()).anchorAt(H.TOP_LEFT).locAt(H.BOTTOM_RIGHT);
  grp.add(p.createCopy()).anchorAt(H.TOP_RIGHT).locAt(H.BOTTOM_LEFT);
  
  
  /*
   * We're setting `d1` to style its children
   * via `stylesChildren(true)`
   * 
   * `d2` will remain to its default behavior.
   *
   * Once again, HGroups by default will style
   * its children by default.
   *
   * To remove this behavior,
   * call `stylesChildren(false)`
   */
  d1.stylesChildren(true);
  
  
  /*
   * setting `stylesChildren` to true would affect
   * the following fields of the children:
   *
   * - fill color
   * - stroke color
   * - stroke weight
   * - stroke join
   * - stroke cap
   */
  
  // d1 will pass its styling to its children
  d1.fill(H.DGREY,128)
    //.noFill()
    .stroke(H.RED)
    .strokeWeight(4)
    .strokeJoin(BEVEL)
    .strokeCap(ROUND);
  
  // d2 will only style itself
  d2.fill(H.DGREY,128)
    .stroke(H.RED)
    .strokeWeight(4)
    .strokeJoin(BEVEL)
    .strokeCap(ROUND);
  
  // grp will also pass the styling to its children,
  // because that's HGroup's default behavior
  grp.fill(H.DGREY,128)
    .stroke(H.RED)
    .strokeWeight(4)
    .strokeJoin(BEVEL)
    .strokeCap(ROUND);
  
  
  H.add(new HText("stylesChildren(true)",12)).anchorAt(H.CENTER_TOP).loc(width/2-170,height*3/4);
  H.add(new HText("stylesChildren(false)",12)).anchorAt(H.CENTER_TOP).loc(width/2,height*3/4);
  H.add(new HText("HGroup defaults",12)).anchorAt(H.CENTER_TOP).loc(width/2+170,height*3/4);
  
  H.drawStage();
  noLoop();
}

