HDrawablePool pool;
HPolarLayout layout;

int colshifter = 0;

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
						.fill(#000000)
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

	colorMode(HSB, 360, 100, 100);

	colshifter++;
	if (colshifter >360) colshifter=0;

	for (HDrawable d : pool) {
		color tempClr = color(colshifter, random(50, 100), random(75, 100));
		d.fill( tempClr );
	}

	H.drawStage();
}

