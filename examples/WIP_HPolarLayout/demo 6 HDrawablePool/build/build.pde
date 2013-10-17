HDrawablePool pool;
HPolarLayout layout;

void setup(){
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	layout = new HPolarLayout(0.25, 10, width / 2, height / 2, true, 0.005);

	pool = new HDrawablePool( 1100 );
	pool.autoAddToStage()
		.add ( new HRect(10).rounding(3) )
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill(#ff3300)
						.anchorAt(H.CENTER)
					;

					layout.applyLayout(d);
				}
			}
		)
		.requestAll()
	;
}
 
void draw(){
	H.drawStage();
}

