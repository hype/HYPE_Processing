import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HOscillator;

HDrawablePool pool;
HOscillator   rX, rY, rZ;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	rX = new HOscillator().range(-180,180).speed(0.1).freq(5);
	rY = new HOscillator().range(-360,360).speed(0.1).freq(5);
	rZ = new HOscillator().range(-90,90).speed(0.1).freq(5);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HBox())
		.layout(new HGridLayout().startX(-125).startY(-125).spacing(100,100).cols(10))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					int ranSize = 25 + ( (int)random(3)*50 );
					HBox d = (HBox) obj;
					d.depth(ranSize).width(ranSize).height(ranSize).noStroke().z( (int)random(-400, 0) ).rotationZ(random(360));

					new HOscillator()
						.target(d)
						.property(H.Z)
						.relativeVal(d.z())
						.range(-300, 300)
						.speed(1)
						.freq(3)
						.currentStep(i*2)
					;
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	pointLight(255,  51,   0,        0, height/2, -300); // orange
	pointLight(0,   149, 168,    width, height/2, -300); // teal
	pointLight(255, 204,   0,  width/2, height/2, -400); // yellow

	rX.nextRaw();
	rY.nextRaw();
	rZ.nextRaw();

	for(HDrawable d : pool) {
		d.rotationX( rX.curr() );
		d.rotationY( rY.curr() );
		d.rotationZ( rZ.curr() );
	}

	H.drawStage();
}
