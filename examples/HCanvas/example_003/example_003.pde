HCanvas canvas;
HDrawablePool pool;
HTimer timer;

final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

void setup() {
	size(640,640,P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();

	canvas = new HCanvas(P3D).autoClear(false).fade(2);
	H.add(canvas);

	pool = new HDrawablePool(300);
	pool.autoParent(canvas)
		.add (
			new HRect().rounding(5)
		)
	    .onRequest (
		    new HCallback() {
		    	public void run(Object obj) {
		    		final HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill( colors.getColor() )
						.loc( (int)random(width), (int)random(height), -(int)random(2000) )
						.anchorAt(H.CENTER)
						.size( 5+((int)random(10)*5) )
					;

					int i = pool.currentIndex();

					final HOscillator ro = new HOscillator().speed(1f).range(-90,90).freq(2f).property(H.ROTATION).waveform(H.SINE);
					ro.target( d ).currentStep( i*2 );

					final HOscillator so = new HOscillator().speed(0.5f).range(0,2).freq(4f).property(H.SCALE).waveform(H.SINE);
					so.target( d ).currentStep( i*2 );

					final HTween zTween = new HTween()
						.target(d).property(H.Z)
						.start(-(int)random(2000)).end(100).ease(0.0005).spring(0.95)
					;

					final HCallback onDisappear = new HCallback(){public void run(Object obj) {
						pool.release(d);
					}};

					zTween.callback(onDisappear);
				}
			}
		)
	;

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(250)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					pool.request();
				}
			}
		)
	;
}

void draw() {
	H.drawStage();
}

