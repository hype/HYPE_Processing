HDrawablePool pool;

int cellSize = 36;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	final HColorPool colors = new HColorPool()
		.add(#FFFFFF, 9)
		.add(#ECECEC, 9)
		.add(#CCCCCC, 9)
		.add(#333333, 3)
		.add(#0095a8, 2)
		.add(#00616f, 2)
		.add(#FF3300)
		.add(#FF6600)
	;

	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
		)
		.layout (
			new HGridLayout()
			.startX(21)
			.startY(7)
			.spacing(26,26)
			.cols(24)
		)
		.setOnCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d
						.fill( colors.getColor() )
						.anchorAt(H.CENTER)
						.rotation( 45 )
						.size( cellSize )
					;
				}
			}
		)
		.requestAll();

	H.drawStage();
	noLoop();
}

void draw() {}