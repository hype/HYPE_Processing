HDrawablePool pool;
HGridLayout grid;
HColorPool colors;

int cellSize = 25;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	 colors = new HColorPool()
	    .add(#FFFFFF, 9)
	    .add(#F7F7F7, 9)
	    .add(#ECECEC, 9)
	    .add(#0095A8, 6)
	    .add(#00616F, 6)
	    .add(#333333, 6)
	    .add(#FF3300)
	    .add(#FF6600);

	grid = new HGridLayout()
		.startX(5)
		.startY(5)
		.spacing(5,5)
		.cols(126);

	pool = new HDrawablePool(15876);
	pool.autoAddToStage()
		.add (
			new HRect(5)
		)
		.layout(grid)
		.onCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
		    		int i = pool.currentIndex();
		    		d.fill(colors.getColor(i*3));
				}
			}
		)
		.requestAll();

	H.drawStage();
	noLoop();
}

void draw() {}