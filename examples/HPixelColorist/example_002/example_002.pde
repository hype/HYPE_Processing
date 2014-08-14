/* @pjs preload="sintra.jpg"; */

HDrawablePool pool;

float resizeFactor = 1.5;
int cellSize = round(25*resizeFactor);
int w = round(640*resizeFactor);
int h = round(640*resizeFactor);

void setup() {
	size(w, h);
	H.init(this).background(#202020);
	smooth();

	HImage img = (HImage)new HImage("sintra.jpg").size(w, h);
	final HPixelColorist colors = new HPixelColorist(img)
		.fillOnly()
		// .strokeOnly()
		// .fillAndStroke()
	;

	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
		)

		.layout (
			new HGridLayout()
			.startX(round(21*resizeFactor))
			.startY(round(21*resizeFactor))
			.spacing(cellSize+1,cellSize+1)
			.cols(24)
		)

		.onCreate (
			new HCallback(){
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.anchorAt(H.CENTER)
						.size(cellSize)
					;

					colors.applyColor(d);
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {}
