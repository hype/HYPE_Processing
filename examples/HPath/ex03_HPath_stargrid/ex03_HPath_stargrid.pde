HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	pool = new HDrawablePool(49);
	pool.autoAddToStage()
		.add (
			new HPath()
			.star( 5, 0.75 )
		)
		.layout (
			new HGridLayout()
			.startX(81)
			.startY(81)
			.spacing(80,80)
			.cols(7)
		)
		.onCreate (
		    new HCallback() {
		    	public void run(Object obj) {
					int ranEdges = (int)random(5) + 5;
					float ranDepth = (int)(random(3)*0.25) + 0.25;

		    		HDrawable d = (HDrawable) obj;
					d
						// .star( ranEdges, ranDepth )
						.noStroke()
						.fill( colors.getColor() )
						.anchorAt(H.CENTER)
						.rotation( (int)random(360) )
					;
				}
			}
		)
		.requestAll();

	H.drawStage();
	noLoop();
}

void draw() {}

