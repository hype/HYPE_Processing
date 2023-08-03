import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HPixelColorist;
import hype.extended.layout.HGridLayout;

int            gridX   = 5;
int            gridY   = 5;
int            gridZ   = 5;
int            gridMax = gridX * gridY * gridZ;

HDrawablePool  pool;
int            boxSize = 200;

HImage         clrSRC;
HPixelColorist clrHPC;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( clrSRC = new HImage("color.png") ).visibility(false);
	clrHPC = new HPixelColorist(clrSRC);

	pool = new HDrawablePool(gridMax);
	pool.autoAddToStage()
		.add(new HBox().texture("tex.png"))
		.layout (new HGridLayout().startX(-400).startY(-400).startZ(-400).spacing(400, 400, 400).rows(gridX).cols(gridY))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HRect marker;
					H.add( marker = new HRect(2,10) );
					marker.noStroke().fill(#CCCCCC).loc(0,15).visibility(false);
					new HOscillator().target(marker).property(H.X).range(0, clrSRC.width()).speed(1).freq(1).currentStep(i*2);

					HBox d = (HBox) obj;
					d.depth(boxSize).width(boxSize).height(boxSize).strokeWeight(2).stroke(0,225).fill(255,225);
					d.extras( new HBundle().obj("m", marker) );

					new HOscillator().target(d).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(1).currentStep(i*0.25);
					new HOscillator().target(d).property(H.ROTATIONY).range(-360, 360).speed(0.2).freq(1).currentStep(i*0.25);
					new HOscillator().target(d).property(H.ROTATIONZ).range(-360, 360).speed(0.3).freq(1).currentStep(i*0.25);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	lights();

	pushMatrix();
		translate(width/2, height/2, -200);
		rotateY( radians(frameCount) );
		H.drawStage();
	popMatrix();

	for (HDrawable d : pool) {
		HBundle obj = d.extras();
		HRect marker = (HRect) obj.obj("m");

		int   tempPos   = (int)constrain(marker.x(), 0, clrSRC.width()-1);
		color tempColor = clrHPC.getColor(tempPos,0);
		d.fill(tempColor);
	}
}
