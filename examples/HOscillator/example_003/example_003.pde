HDrawablePool pool;
HOscillator hoBase;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

    hoBase = new HOscillator()
      .speed(1f)
      .range(6,200) // absolute / height min = 6 / height max = 200
      .freq(3f)
      .property(H.HEIGHT)
      .waveform(H.SQUARE) // 4 modes / SINE, SQUARE, TRIANGLE, SAW
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

					HOscillator ho = hoBase.createCopy();
					ho.target( d ).currentStep( i * 3 );
				}
			}
		)
		.requestAll();
}

void draw() {
	H.drawStage();
}