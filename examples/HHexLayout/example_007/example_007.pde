HDrawablePool pool;
HColorPool colors;

void setup(){
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC, #999999, #666666, #4D4D4D, #333333);

	pool = new HDrawablePool(168);
	pool.autoAddToStage()
		.add( new HPath() )

		.layout(
			new HHexLayout()
			.spacing(20)
			.offsetX(0)
			.offsetY(0)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HPath d = (HPath) obj;
					d
						.polygon(6, -90)
						.size(60)
						.anchorAt(H.CENTER)
						.stroke(colors.getColor())
						.noFill()
					;
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
	noLoop();
}
 
void draw(){ }

