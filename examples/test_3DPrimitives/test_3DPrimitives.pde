void setup() {
  size(640, 640, P3D);
  H.init(this).use3D(true);
  
  HBox box = (HBox) H.add(new HBox());
  box.depth(150) // depth is a 3D specific method, so put this first
    .width(150)
    .height(150)
    .x(640/4)
    .y(320)
    .z(-500)
    .rotationZ();
  
  HSphere sphere = (HSphere) H.add(new HSphere());
  sphere.loc(640*3/4, 320, -500)
    .size(200); // By definition, a sphere's width, height and depth
                // is always the same.
  
  /*
   * By definition, a sphere's width, height and depth is always the
   * same. So separately setting width, height and depth won't do
   * anything.
   */ 
  
  H.drawStage();
  noLoop();
}
