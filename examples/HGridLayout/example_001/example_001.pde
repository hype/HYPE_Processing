HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();
	
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
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d
						.fill( #ECECEC )
					;
				}
			}
		)
		.requestAll();

	H.drawStage();
	noLoop();
}

void draw() {}