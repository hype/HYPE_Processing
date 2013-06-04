/* @pjs preload="gradient.jpg"; */

HCanvas canvas;
HDrawablePool pool;
HPixelColorist colors;

void setup() {
  size(640,640,P3D);
  H.init(this).background(#000000).autoClear(true).use3D(true);
  smooth();
  
  PImage img = loadImage("gradient.jpg");
  colors = new HPixelColorist(img);

  canvas = new HCanvas(P3D).autoClear(true);
  H.add(canvas);

  pool = new HDrawablePool(1000);

  pool.autoParent(canvas)
    .add( new HRect().rounding(10) )

    .onCreate(new HCallback(){public void run(Object obj) {
      HDrawable d = (HDrawable) obj;
      d
        .size( (int)random(40,80) , (int)random(60,80) )
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
          .range(50,255)
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

        .obj("zo", new HOscillator()
          .property(H.Z)
          .waveform(H.SINE)
          .speed( random(.005,.01) )
          .freq(15)
          .range( -400 , 400 )
        )
      ;
    }})

    .onRequest(new HCallback(){public void run(Object obj) {
      int i = pool.currentIndex();

      HDrawable d = (HDrawable) obj;
      d.scale(1);
      d.alpha(0);
      d.loc((int)random(width),(int)random(height),-(int)random(200));

      HOscillator xo = (HOscillator) d.obj("xo"); xo.register().currentStep(i).target(d);
      HOscillator ao = (HOscillator) d.obj("ao"); ao.register().currentStep(i).target(d);
      HOscillator wo = (HOscillator) d.obj("wo"); wo.register().currentStep(i).target(d);
      HOscillator ro = (HOscillator) d.obj("ro"); ro.register().currentStep(i).target(d);
      HOscillator zo = (HOscillator) d.obj("zo"); zo.register().currentStep(i*5).target(d);

    }})

    .onRelease(new HCallback(){public void run(Object obj) {
      HDrawable d = (HDrawable) obj;

      HOscillator xo = (HOscillator) d.obj("xo"); xo.unregister();
      HOscillator ao = (HOscillator) d.obj("ao"); ao.unregister();
      HOscillator wo = (HOscillator) d.obj("wo"); wo.unregister();
      HOscillator ro = (HOscillator) d.obj("ro"); ro.unregister();
      HOscillator zo = (HOscillator) d.obj("zo"); zo.unregister();

    }});
  
  new HTimer(50).callback(new HCallback(){public void run(Object obj){
    pool.request();
  }});
}

void draw() {
  HIterator<HDrawable> it = pool.iterator();
  while(it.hasNext()) {
    HDrawable d = it.next();
    d.loc( d.x(), d.y() - random(0.25,1), d.z() );

    d.noStroke();
    d.fill(colors.getColor(d.x(), d.y()));

    // if the z axis hits this range, change fill to white
    if (d.z() > -10 && d.z() < 10){
      d.fill(#FFFFCC);
    }

    if (d.y() < -40) {
      pool.release(d);
    }
  }

  H.drawStage();
}

