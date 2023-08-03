import hype.*;
import hype.extended.behavior.HOscillator;

HDrawablePool pool;
int           boxSize = 500;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	HBox b = new HBox();
	b.textureFront("tex1.png");
	b.textureBack("tex2.png");
	b.textureTop("tex3.png");
	b.textureBottom("tex4.png");
	b.textureLeft("tex5.png");
	b.textureRight("tex6.png");

	pool = new HDrawablePool(25);
	pool.autoAddToStage()
		.add(b)
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HBox d = (HBox) obj;
					d.depth(boxSize).width(boxSize).height(boxSize).strokeWeight(2).stroke(0,225).fill(255,225).x(width/2).y(height/2).z(-500);

					new HOscillator().target(d).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(1).currentStep(i);
					new HOscillator().target(d).property(H.ROTATIONY).range(-360, 360).speed(0.2).freq(1).currentStep(i);
					new HOscillator().target(d).property(H.ROTATIONZ).range(-360, 360).speed(0.3).freq(1).currentStep(i);
					new HOscillator().target(d).property(H.SCALE).range(0.5, 1.0).speed(1).freq(2).currentStep(i);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	lights();
	H.drawStage();
}
