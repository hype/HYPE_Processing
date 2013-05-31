/* @pjs font="DroidSerifBoldItalic.ttf"; */

HDrawablePool pool;

final HColorPool colors = new HColorPool(#111111, #202020, #242424, #333333, #4D4D4D, #CCCCCC);

void setup() {
  size(640,640);
  H.init(this).background(#000000);
  smooth();
  
  PFont type = createFont("DroidSerifBoldItalic.ttf", 24);
   
  pool = new HDrawablePool(1000);

  pool.autoAddToStage()
    .add( new HRect().rounding(5) )

    .onCreate(new HCallback(){public void run(Object obj) {
      HDrawable d = (HDrawable) obj;
      d
        .strokeWeight(8)
        .stroke(#FFFFFF, 10)
        .strokeCap(ROUND)
        .strokeJoin(ROUND)
        .fill(colors.getColor())
        .size( (int)random(4,10) , (int)random(8,12) )
        .loc(  (int)random(width), (int)random(height) )
        .anchorAt(H.CENTER)

        .obj("xo", new HOscillator()
          .property(H.X)
          .waveform(H.SINE)
          .speed( random(.005,.2) )
          .freq(10)
          .range( d.x() - (int)random(5,10) , d.x() + (int)random(5,10) )
        )

        .obj("ao", new HOscillator()
          .property(H.ALPHA)
          .waveform(H.SINE)
          .speed( random(.3,.9) )
          .freq(5)
          .range(0,255)
        )

        .obj("wo", new HOscillator()
          .property(H.WIDTH)
          .waveform(H.SINE)
          .speed( random(.05,.2) )
          .freq(10)
          .range(-d.width(),d.width())
        )

        .obj("ro", new HOscillator()
          .property(H.ROTATION)
          .waveform(H.SINE)
          .speed( random(.005,.05) )
          .freq(10)
          .range(-180,180)
        )
      ;
    }})

    .onRequest(new HCallback(){public void run(Object obj) {
      int i = pool.currentIndex();

      HDrawable d = (HDrawable) obj;
      d.scale(1);
      d.alpha(0);
      d.loc((int)random(width),(int)random(height));

      HOscillator xo = (HOscillator) d.obj("xo"); xo.register().currentStep(i).target(d);
      HOscillator ao = (HOscillator) d.obj("ao"); ao.register().currentStep(i).target(d);
      HOscillator wo = (HOscillator) d.obj("wo"); wo.register().currentStep(i).target(d);
      HOscillator ro = (HOscillator) d.obj("ro"); ro.register().currentStep(i).target(d);

    }})

    .onRelease(new HCallback(){public void run(Object obj) {
      HDrawable d = (HDrawable) obj;

      HOscillator xo = (HOscillator) d.obj("xo"); xo.unregister();
      HOscillator ao = (HOscillator) d.obj("ao"); ao.unregister();
      HOscillator wo = (HOscillator) d.obj("wo"); wo.unregister();
      HOscillator ro = (HOscillator) d.obj("ro"); ro.unregister();

    }});
  
  new HTimer(50).callback(new HCallback(){public void run(Object obj){
    pool.request();
  }});

  HText f1 = new HText("dust",200,type);
  f1.fill(#ECECEC).anchorAt(H.CENTER).loc(width/2,height/2);
  H.add(f1);

}

void draw() {
  HIterator<HDrawable> it = pool.iterator();
  while(it.hasNext()) {
    HDrawable d = it.next();
    d.loc( d.x(), d.y() - random(0.25,1) );

    if (d.y() < -40) {
      pool.release(d);
    }
  }

  H.drawStage();

}

