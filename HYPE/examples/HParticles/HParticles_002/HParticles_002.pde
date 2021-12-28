import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.behavior.HParticles;
import hype.extended.colorist.HColorPool;

HDrawablePool pool;
HParticles    hp;
HColorPool    colors;
HOscillator   xRot, yRot, zRot, zPos;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true).autoClear(true);

	hp = new HParticles()
		.location(0, 0)
		.minimumLife(10)
		.maximumLife(150)
		.speed(3.0)
		.decay(1.0)
		.fade(false)
	;

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	xRot = new HOscillator().range(-180, 180).speed(0.6).freq(1);
	yRot = new HOscillator().range(-180, 180).speed(0.4).freq(1);
	zRot = new HOscillator().range(-180, 180).speed(0.2).freq(1);
	zPos = new HOscillator().range(-360, 360).speed(0.5).freq(3);

	pool = new HDrawablePool(400);
	pool.autoAddToStage()
		.add(new HBox())
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(colors.getColor()).size(5).anchorAt(H.CENTER).rotation(45);
					hp.addParticle(d);
				}
			}
		)
		.requestAll()
	;
}


void draw() {
	xRot.nextRaw();
	yRot.nextRaw();
	zRot.nextRaw();
	zPos.nextRaw();

	lights();

	pushMatrix();
		translate(width/2, height/2, zPos.curr());
		rotateX(radians(xRot.curr()));
		rotateY(radians(yRot.curr()));
		rotateZ(radians(zRot.curr()));
		H.drawStage();
	popMatrix();
}
