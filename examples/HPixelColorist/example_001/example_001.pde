// As seen here, we need to preload Images and Fonts.
//
// See http://processingjs.org/reference/preload/
// and http://processingjs.org/reference/font/
// for more information.

/* @pjs preload="sintra.jpg"; */

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	PImage img = loadImage("sintra.jpg");
	final HPixelColorist colors = new HPixelColorist(img)
	    .fillOnly()
	    // .strokeOnly()
	    // .fillAndStroke()
    ;
    
	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add (
			new HRect(25)
			.rounding(4)
		)
		.layout (
			new HGridLayout()
			.startX(9)
			.startY(9)
			.spacing(26,26)
			.cols(24)
		)
	    .onCreate (
		    new HCallback(){
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
			        colors.applyColor(d);
		    	}
			}
	    )
		.requestAll();

	H.drawStage();
	noLoop();
}

void draw() {}
