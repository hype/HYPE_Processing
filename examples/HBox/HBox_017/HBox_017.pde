import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.behavior.HSwarm;
import hype.extended.colorist.HPixelColorist;

PGraphics      pg;
HCanvas        canvas;
int            canvasW = 500;
int            canvasH = 500;
HRect          r;

HDrawablePool  pool;
int            boxSize = 500;

HDrawablePool  poolSwarm;
HSwarm         swarm;

HImage         clrSRC;
HPixelColorist clrHPC;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( clrSRC = new HImage("color.png") );
	clrHPC = new HPixelColorist(clrSRC);

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
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = poolSwarm.currentIndex();

					HRect marker;
					H.add( marker = new HRect(2,10) );
					marker.noStroke().fill(#CCCCCC).loc(0,15);
					new HOscillator().target(marker).property(H.X).range(0, clrSRC.width()).speed(1).freq(1).currentStep(i*10);

					HDrawable d = (HDrawable) obj;
					d
						.size((int)random(10,100), (int)random(2,40) )
						.noStroke()
						.fill(#FFFFFF)
						.loc( width/2, height/2 )
						.anchorAt( H.CENTER )
						.scale(2)
						.extras( new HBundle().obj("m", marker) )
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

	for (HDrawable d : poolSwarm) {
		HBundle obj = d.extras();
		HRect marker = (HRect) obj.obj("m");

		int   tempPos   = (int)constrain(marker.x(), 0, clrSRC.width()-1);
		color tempColor = clrHPC.getColor(tempPos,0);
		d.fill(tempColor);
	}

	noStroke(); fill(#111111);
	rect(0, 30, 100, 100);
	image(pg, 0, 30, 100, 100);
}
