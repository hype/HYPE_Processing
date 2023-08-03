import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.layout.HSphereLayout;

HDrawablePool pool;
HSphereLayout layout;
HOscillator   reducer_wave;
float         r = 0;
float         nx, ny;

void setup() {
	size(640,640,P3D); 
	H.init(this).background(#242424).use3D(true);

	nx = ny = 0.0;

	reducer_wave = new HOscillator().range(-0.5, 2.5).speed(1.5).freq(2.2).waveform(H.TRIANGLE);

	layout = new HSphereLayout()
		.loc(width/2, height/2, 0)
		.radius(100)
		.rotate(true)
		.ignorePoles()
		.offsetRows(true)
		.rows(32)
	;

	pool = new HDrawablePool(320);
	pool.autoAddToStage()
		.add(new HBox())
		.layout(layout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.size(5).depth(10).noStroke();

					int i = pool.currentIndex();

					PVector pt  = new PVector(d.x(), d.y(), d.z());
					PVector loc = new PVector();
					loc = PVector.sub(layout.loc(), pt);
					loc.normalize();

					int row = (i/10)%32;
					int col = i%10;

					d.extras( new HBundle().obj("loc", loc).num("row", row).num("col", col) );

					switch ((i / 10) % 10) {
						case 0: case 5: d.fill(#FF6600); break;
						case 1: case 6: d.fill(#0095a8); break;
						case 2: case 7: d.fill(#eeeeee); break;
						case 3: case 8: d.fill(#FF3300); break;
						case 4: case 9: d.fill(#00616f); break;
					}

					new HOscillator().target(d).property(H.SCALE).range(1.25, 3.5).speed(0.75).freq(1.6).addReducer(reducer_wave).currentStep(i*3);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	if (mousePressed) {
		translate(width/2, height/2);
		rotateX(map(mouseY, 0, height, -(TWO_PI / 2), TWO_PI/2));
		rotateY(map(mouseX, 0, width, -(TWO_PI / 2), TWO_PI/2));
		translate(-width/2, -height/2);
	}

	translate(width/2, height/2);
	rotateY(r);
	translate(-width/2, -height/2);

	for (HDrawable d : pool) {
		HBundle obj = d.extras();

		PVector loc = (PVector) obj.obj("loc");
		int     row = (int)     obj.num("row");
		int     col = (int)     obj.num("col");

		PVector pt = new PVector();
		pt.add(loc);
		
		float rad = noise(nx + (0.03 * col), ny + (0.03 * row)) * 300;

		pt.mult(rad);
		pt.add(layout.loc());

		d.x(pt.x);
		d.y(pt.y);
		d.z(pt.z);
	}

	lights();
	H.drawStage();

	r += radians(.2);
	nx += 0.01;
	ny += 0.01;
} 
