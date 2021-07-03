import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.layout.HGridLayout;

HDrawablePool  pool;
HOscillator    o;
HOscillator    o2;

void setup() {
  size(640, 640, P3D);
  H.init(this).background(#242424).use3D(true);

  o = new HOscillator()
    .property(H.Z)
    .range(-120, 0)
    .speed(2)
    .freq(1)
    .currentStep(4)
    .waveform(H.EASE)
    ;

  o2 = new HOscillator()
    .property(H.Z)
    .range(0, 120)
    .speed(0.7F)
    .freq(2)
    .currentStep(39)
    .waveform(H.SINE)
    ;

  pool = new HDrawablePool(400);
  pool.autoAddToStage()
    .add(new HLine(0, 0, 0, 0, 0, 32))
    .layout(
    new HGridLayout()
    .startX(16)
    .startY(16)
    .spacing(32, 32)
    .cols(20)
    )
    .onCreate(
    new HCallback() {
    public void run(Object obj) {
      HLine d = (HLine) obj;
      int i = pool.currentIndex();
      d
        .strokeWeight((i+1)%4)
        .stroke(#999999)
        ;
    }
  }
  )
  .requestAll()
    ;
}

void draw() {
  o.nextRaw(); //get oscillator values
  o2.nextRaw();
  for (HDrawable d : pool)
  {
    if (d instanceof HLine) {
      HLine l = (HLine)d;
      l
        .x1(o2.curr()) 
        .x2(o.curr())
        .y1(o.curr()) 
        .y2(o2.curr())
        .z1(o2.curr()) 
        .z2(o.curr())
        ;
    }
  }
  H.drawStage();
}