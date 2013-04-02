HDrawablePool pool;

int cellSize = 25;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();
	
	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add (
			new HRect(cellSize)
			.rounding(4)
		)
		.layout (
			new HGridLayout()
			.startX(8)
			.startY(8)
			.spacing(cellSize+1,cellSize+1)
			.cols(24)
		)
		.setOnCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d.fill( #ECECEC );
				}
			}
		)
		.requestAll();

	H.drawStage();
	noLoop();
}

void draw() {}