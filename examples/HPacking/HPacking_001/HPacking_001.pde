import hype.*;
import hype.extended.behavior.HPacking;

HDrawablePool pool;
HPacking circle_packing;

void setup() {
	size(640,640,P3D);
	smooth();
	H.init(this).background(#242424);

	circle_packing = new HPacking();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HEllipse())
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HEllipse d = (HEllipse) obj;
					d.fill(255).noStroke();

					circle_packing.addTarget(d);
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
	circle_packing.reset();
	
	for (HDrawable d : pool) {
		circle_packing.addTarget(d);
	}

	//pool.drain();
	//pool.requestAll();
}
