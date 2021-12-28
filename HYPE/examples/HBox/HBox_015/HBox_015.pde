import hype.*;
import hype.extended.behavior.HOscillator;

PGraphics     pg;
HCanvas       canvas;
int           canvasW = 500;
int           canvasH = 500;
HRect         r;

HDrawablePool pool;
int           boxSize = 500;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add(canvas = new HCanvas(canvasW,canvasH).autoClear(false).fade(5));
	canvas.x(width+1).add( r = new HRect(50) ).noStroke().fill(#FF3300).anchorAt(H.CENTER).rotate(45);

	pg = createGraphics((int) canvas.width(), (int) canvas.height(), P3D);
	pg.beginDraw();
		pg.clear();
	pg.endDraw();

	pool = new HDrawablePool(1);
	pool.autoAddToStage()
		.add(new HBox().texture(pg))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HBox d = (HBox) obj;
					d.depth(boxSize).width(boxSize).height(boxSize).strokeWeight(2).stroke(#FF3300, 100).fill(255,225).x(width/2).y(height/2).z(-500);

					new HOscillator().target(d).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(1).currentStep(i);
					new HOscillator().target(d).property(H.ROTATIONY).range(-360, 360).speed(0.2).freq(1).currentStep(i);
					new HOscillator().target(d).property(H.ROTATIONZ).range(-360, 360).speed(0.3).freq(1).currentStep(i);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	r.size(20+((int)random(5)*20)).loc( (int)random(canvasW), (int)random(canvasH));
	H.drawStage();

	//update the texture PGraphic

	pg.beginDraw();
		pg.clear();
		pg.image(canvas.graphics(), 0, 0);
	pg.endDraw();

	noStroke(); fill(#111111);
	rect(0, 0, 100, 100);
	image(pg, 0, 0, 100, 100);
}
