import hype.*;
import hype.extended.layout.HPackingLayout;

HDrawablePool pool;
HPackingLayout layout;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	layout = new HPackingLayout().maxSize(250.0).minSize(2.0).numTrys(1500).numItems(300);

	pool = new HDrawablePool(300);
	pool.autoAddToStage()
		.add(new HEllipse())

		.layout(
			layout
		)

		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HEllipse d = (HEllipse) obj;
					d.fill(255).noStroke();
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
	surface.setTitle("FPS: " + frameRate);
}


void mousePressed() {
	pool.drain();
	layout.reset();
	pool.shuffleRequestAll();
}
