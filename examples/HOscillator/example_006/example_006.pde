HDrawablePool pool;
HOscillator yoBase, roBase, hoBase;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(true);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

    yoBase = new HOscillator()
      .speed(2f)
      .range(-200,200) // relative from initial position / y min = -200 / y max = 200
      .freq(0.5f)
      .property(H.Y)
      .waveform(H.SINE)
     ;

    roBase = new HOscillator()
      .speed(1f)
      .range(-180,180) // absolute / rotation min = -180 / rotation max = 180
      .freq(0.5f)
      .property(H.ROTATION)
      .waveform(H.SINE)
     ;

    hoBase = new HOscillator()
      .speed(2f)
      .range(4,200) // absolute / height min = 4 / height max = 200
      .freq(1f)
      .property(H.HEIGHT)
      .waveform(H.SINE)
     ;

	pool = new HDrawablePool(320);
	pool.autoAddToStage()
		.add (
			new HRect(4)
			.rounding(3)
		)
		.layout(new HGridLayout()
			.startX(0)
			.startY(height/2)
			.spacing(2,0)
			.cols(320)
		)
		.onCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		int i = pool.currentIndex();

		    		HDrawable d = (HDrawable) obj;
		    		d.noStroke().fill( colors.getColor(i*100) );
		    		d.anchorAt(H.CENTER);

					HOscillator yo = yoBase.createCopy().relativeVal(d.y());
					HOscillator ro = roBase.createCopy();
					HOscillator ho = hoBase.createCopy();

					yo.target( d ).currentStep( i );
					ro.target( d ).currentStep( i );
					ho.target( d ).currentStep( i );
				}
			}
		)
		.requestAll();
}

void draw() {
	H.drawStage();
}

