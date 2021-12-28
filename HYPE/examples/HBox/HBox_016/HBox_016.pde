import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.behavior.HSwarm;
import hype.extended.colorist.HColorPool;

PGraphics     pg;
HCanvas       canvas;
int           canvasW = 500;
int           canvasH = 500;
HRect         r;

HDrawablePool pool;
int           boxSize = 500;

HDrawablePool poolSwarm;
HSwarm        swarm;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add(canvas = new HCanvas(canvasW,canvasH).autoClear(false).fade(5));
	canvas.x(width+1);

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

	// swarm behavior as texture

	swarm = new HSwarm()
		.addGoal(canvasW/2,canvasH/2)
		.speed(10)
		.turnEase(0.03f)
		.twitch(20)
	;

	poolSwarm = new HDrawablePool(20);
	poolSwarm.autoParent(canvas)
		.add (new HRect().rounding(4))
		.colorist(new HColorPool(#CCE70B, #80C41C, #40A629, #237D26, #FF3300, #FF6600).fillOnly())
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.size((int)random(10,100), (int)random(2,40) )
						.noStroke()
						.loc( width/2, height/2 )
						.anchorAt( H.CENTER )
					;
					swarm.addTarget(d);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

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
