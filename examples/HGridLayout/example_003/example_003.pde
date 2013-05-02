HDrawablePool pool;

int cellSize = 50;

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
			new HRect(cellSize)
			.rounding(4)
		)
		.layout (
			new HGridLayout()
			.startX(32)
			.startY(32)
			.spacing(cellSize/2,cellSize/2)
			.cols(24)
		)

		.onCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill( colors.getColor() )
						.alpha( (int)random(50,200) )
						.anchorAt(H.CENTER)
					;
					
					d.extras(
						new HBundle().num( "letsRotate",random(-2,2) )
					);
				}
			}
		)
		.requestAll();
}

void draw() {
	HIterator<HDrawable> it = pool.iterator();
	while(it.hasNext()) {
		HDrawable d = it.next();
		HBundle extras = d.extras();
		d.rotate(extras.num("letsRotate"));
	}

	H.drawStage();
}

