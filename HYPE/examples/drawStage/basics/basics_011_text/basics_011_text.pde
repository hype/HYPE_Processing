import hype.*;
import hype.extended.colorist.HColorPool;

HColorPool    colors;
HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	PFont type = createFont("DroidSerifBoldItalic.ttf", 24);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HText( "q", 24, type ))
		.add(new HText( "w", 24, type ))
		.add(new HText( "e", 24, type ))
		.add(new HText( "r", 24, type ))
		.add(new HText( "t", 24, type ))
		.add(new HText( "y", 24, type ))

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HText t = (HText) obj;
					t.fill( colors.getColor() );
					t.scale( ((int)random(10)*2) + 1 );
					t.anchorAt(H.CENTER);
					t.loc( (int)random(width), (int)random(height) );
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
