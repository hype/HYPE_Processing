import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HPixelColorist;

HDrawablePool  pool;
int            boxSize   = 500;

HImage         clrSRC;
HPixelColorist clrHPC;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( clrSRC = new HImage("color.png") );
	clrHPC = new HPixelColorist(clrSRC);

	HBox b = new HBox();
	b.textureFront("tex1.png");
	b.textureBack("tex2.png");
	b.textureTop("tex3.png");
	b.textureBottom("tex4.png");
	b.textureLeft("tex5.png");
	b.textureRight("tex6.png");

	pool = new HDrawablePool(50);
	pool.autoAddToStage()
		.add(b)
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HRect marker;
					H.add( marker = new HRect(2,10) );
					marker.noStroke().fill(#CCCCCC).loc(0,15);
					new HOscillator().target(marker).property(H.X).range(0, clrSRC.width()).speed(1).freq(1).currentStep(i*2);

					HBox d = (HBox) obj;
					d.depth(boxSize).width(boxSize).height(boxSize).strokeWeight(2).stroke(0,225).fill(255,225).x(width/2).y(height/2).z(-500);
					d.extras( new HBundle().obj("m", marker) );

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
	lights();
	H.drawStage();

	for (HDrawable d : pool) {
		HBundle obj = d.extras();
		HRect marker = (HRect) obj.obj("m");

		int   tempPos   = (int)constrain(marker.x(), 0, clrSRC.width()-1);
		color tempColor = clrHPC.getColor(tempPos,0);
		d.fill(tempColor);
	}
}
