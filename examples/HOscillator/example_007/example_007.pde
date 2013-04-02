HDrawablePool pool;
HOscillator xoBase, yoBase, roBase, soBase;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(true);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

    xoBase = new HOscillator().speed(1f).range(-300,300).freq(0.5f).property(H.X).waveform(H.SINE);
    yoBase = new HOscillator().speed(2f).range(-300,300).freq(0.7f).property(H.Y).waveform(H.SINE);
    roBase = new HOscillator().speed(0.001).range(0,360).freq(1).property(H.ROTATION).waveform(H.SINE);
    soBase = new HOscillator().speed(1f).range(1,200).freq(4f).property(H.SIZE).waveform(H.SINE);

	pool = new HDrawablePool(400);
	pool.autoAddToStage()
		.add (
			new HRect(4)
			.rounding(20)
		)
		.layout(new HGridLayout()
			.startX(0)
			.startY(height/2)
			.spacing(1,0)
			.cols(400)
		)
		.setOnCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		int i = pool.currentIndex();

		    		HDrawable d = (HDrawable) obj;
		    		d.fill( colors.getColor(i*100) );
		    		d.anchorAt(H.CENTER);

					HOscillator xo = xoBase.createCopy().relativeVal(d.x());
					HOscillator yo = yoBase.createCopy().relativeVal(d.y());
					HOscillator ro = roBase.createCopy();
					HOscillator so = soBase.createCopy();

					xo.target( d ).currentStep( i * d.height()/2 );
					yo.target( d ).currentStep( i * d.height()/2 );
					ro.target( d ).currentStep( i * d.height()/2 );
					so.target( d ).currentStep( i * d.height()/2 );
				}
			}
		)
		.requestAll();
}

void draw() {
	H.drawStage();
}