import hype.*;
import hype.extended.behavior.HOrbiter3D;
import hype.extended.behavior.HOscillator;
import hype.extended.layout.HSphereLayout;

HDrawablePool pool;
HSphereLayout layout;
HOrbiter3D    orb1, orb2;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true);

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(200)
		.rotate(true)
		.useSpiral()
		.numPoints(200)
		.phiModifier(3.0001)
	;
	
	pool = new HDrawablePool(200);
	pool.autoAddToStage()
		.add(new HIcosahedron())
		.layout(layout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.depth(20).size(20, 20).noStroke();

					int i = pool.currentIndex();

					new HOscillator().target(d).property(H.SCALE).range(0.5, 1.5).speed(1.5).freq(1.6).currentStep(i*3);
				}
			}
		)
		.requestAll()
	;

	orb1 = new HOrbiter3D(width/2, height/2, 0).zSpeed(random(0.0, 2.0) + 0.5).ySpeed(random(0.0, 2.0) + 0.5 ).radius(250).zAngle( (int)random(360) ).yAngle( (int)random(360) );
	orb2 = new HOrbiter3D(width/2, height/2, 0).zSpeed(random(0.0, 2.0) + 1.0).ySpeed(random(0.0, 2.0) + 0.5 ).radius(300).zAngle( (int)random(360) ).yAngle( (int)random(360) );
}

void draw() {
	if (mousePressed) {
		translate(width/2, height/2);
		rotateX(map(mouseY, 0, height, -(TWO_PI / 2), TWO_PI/2));
		rotateY(map(mouseX, 0, width, -(TWO_PI / 2), TWO_PI/2));
		translate(-width/2, -height/2);
	}

	orb1._run();
	orb2._run();
	pointLight(35, 35, 35, width/2, height/2.5, 300);      // gray
	pointLight(255, 0, 156, orb1.x(), orb1.y(), orb1.z()); // magenta
	pointLight(0, 100, 180, orb2.x(), orb2.y(), orb2.z()); // blue

	H.drawStage();
} 
