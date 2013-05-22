HDrawablePool pool;
HOscillator xoBase, yoBase, roBase, soBase;
HCanvas canvas;

final HColorPool colors = new HColorPool(#CCE70B, #80C41C, #40A629, #237D26, #FF3300, #FF6600, #0095a8, #00616f);

void setup() {
	size(640,640);
	H.init(this).background(#111111);
	smooth();

	canvas = new HCanvas().autoClear(false).fade(10);
	H.add(canvas);

    xoBase = new HOscillator().speed(0.3).range(-600,300).freq(0.5).property(H.X).waveform(H.SINE);
    yoBase = new HOscillator().speed(0.2).range(-300,300).freq(0.7).property(H.Y).waveform(H.SINE);
    roBase = new HOscillator().speed(0.7).range(0,360).freq(2).property(H.ROTATION).waveform(H.SINE);
    soBase = new HOscillator().speed(0.3).range(0.5,4).freq(5).property(H.SCALE).waveform(H.SINE);

	pool = new HDrawablePool(400);
	pool.autoParent(canvas)
		.add (
			new HPath()
			.star( 5, 0.4, -90 ).size(75).noStroke().fill(#FFFFFF)
		)
		.layout(new HGridLayout()
			.startX(0)
			.startY(height/2)
			.spacing(2,0)
			.cols(400)
		)
		.onCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		int i = pool.currentIndex();

		    		HDrawable d = (HDrawable) obj;
		    		d.noStroke().fill( colors.getColor(i*100), 3 );
		    		d.anchor(0,75);

					HOscillator xo = xoBase.createCopy().relativeVal(d.x());
					HOscillator yo = yoBase.createCopy().relativeVal(d.y());
					HOscillator ro = roBase.createCopy();
					HOscillator so = soBase.createCopy();

					xo.target( d ).currentStep( i );
					yo.target( d ).currentStep( i );
					ro.target( d ).currentStep( i );
					so.target( d ).currentStep( i );
				}
			}
		)
		.requestAll();
}

void draw() {
	H.drawStage();
}

