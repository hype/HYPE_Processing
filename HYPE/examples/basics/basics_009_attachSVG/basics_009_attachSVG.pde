import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;

HColorPool    colors;
HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly();

	pool = new HDrawablePool(121);
	pool.autoAddToStage()
		.add(new HShape("art1.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("art2.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("art3.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("art4.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("art5.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("art6.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))

		.layout( new HGridLayout().startX(70).startY(70).spacing(50,50).cols(11) )

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d.strokeWeight(2).stroke(#000000).rotation( ((int)random(4)) * 90 );
					d.randomColors(colors);
				}
			}
		)
		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {

}
