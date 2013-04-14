HDrawablePool pool;
HOscillator yoBase;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

    yoBase = new HOscillator()
      .speed(1f)
      .range(220,420) // absolute / y min = 220 / y max = 420
      .freq(2f) 
      .waveform(H.SINE)
     ;

	pool = new HDrawablePool(90);
	pool.autoAddToStage()
		.add (
			new HRect(6)
			.rounding(2)
			.anchorAt(H.CENTER)
		)
		.layout(new HGridLayout()
			.startX(9)
			.startY(height/2)
			.spacing(7,0)
			.cols(90)
		)
		.onCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		int i = pool.currentIndex();

		    		HDrawable d = (HDrawable) obj;
		    		d.fill( colors.getColor() );

					// Create an oscillator with yoBase's values
					HOscillator yo = yoBase.createCopy();
					// set osc's target to d / set osc's current step
					yo.target( d ).currentStep( i * 3 );
				}
			}
		)
		.requestAll();
}

void draw() {
	H.drawStage();
}