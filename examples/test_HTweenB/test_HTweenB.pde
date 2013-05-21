void setup() {
  size(800,600,P3D);
  background(255);
  H.init(this).use3D(true);
  
  new HTween()
    .target(H.add(new HRect()).anchorAt(H.CENTER))
    .property(H.LOCATION)
    .ease(random(.01,1))
    .spring(random(1))
    .start(0,0,0)
    .end(width/2,height/2,-1000)
    .callback(new HCallback(){public void run(Object obj) {
      // When callback is called, HTween passes itself to the callback
      HTween tween = (HTween) obj;
      tween.target().fill(H.RED);
    }});
  
  new HTween()
    .target(H.add(new HEllipse()).anchorAt(H.CENTER).loc(width*3/4,height*3/4))
    .property(H.Z)
    .ease(random(.01,1))
    .spring(random(9))
    .start(0)
    .end(-500)
    .callback(new HCallback(){public void run(Object obj){
      HTween tween = (HTween) obj;
      tween.target().fill(H.GREEN);
    }});
  
  
  H.add(new HPath().vertex(0,height/2).vertex(width,height/2).endPath());
  H.add(new HPath().vertex(width/2,0).vertex(width/2,height).endPath());
}

void draw() {
  H.drawStage();
}

