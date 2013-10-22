HDrawablePool pool;
HColorPool colors;

void setup(){
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	pool = new HDrawablePool(1045);
	pool.autoAddToStage()
		.add( new HPath() )

		.layout(
			new HHexLayout()
			.spacing(16)
			.offsetX(0)
			.offsetY(0)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HPath d = (HPath) obj;
					d
						.star( 5, 0.5, -90 )
						.size(27)
						.anchorAt(H.CENTER)
						.noStroke()
						.fill(colors.getColor())
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

