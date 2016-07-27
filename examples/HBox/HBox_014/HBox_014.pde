import hype.*;
import hype.extended.behavior.HOscillator;

HDrawablePool pool;
PGraphics g;
HCanvas canvas;
HRect   rect;

int boxSize = 400;

void setup() {
	size(640,640,P3D);
	background(#242424);
	H.init(this).background(#242424).use3D(true).autoClear(false);
	lights();

	canvas = new HCanvas().autoClear(false).fade(5);
	canvas.add( rect = new HRect(50).rounding(5) ).noStroke().fill(#FF3300).rotate(45);
	H.add(canvas);
	canvas.x(width + 1);//put canvas offscreen

	//create our PGraphics for the texture
	g = createGraphics((int) canvas.width(), (int) canvas.height(), P3D);
	g.beginDraw();
		g.clear();
	g.endDraw();


	HBox b = new HBox();
	b.noStroke();
	b.texture(g);

	pool = new HDrawablePool(1);
	pool.autoAddToStage()
		.add(b)
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HBox d = (HBox) obj;
					d.x(width/2).y(height/2).z(-500);

					d.depth(boxSize);
					d.width(boxSize);
					d.height(boxSize);
					d.noStroke();
					d.strokeWeight(0);

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(-90, 90)
						.speed(0.2)
						.freq(3)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-90, 180)
						.speed(0.8)
						.freq(1)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(-360, 360)
						.speed(0.2)
						.freq(1)
						.currentStep(i)
					;



					new HOscillator()
						.target(d)
						.property(H.X)
						.range(-200, 200)
						.relativeVal(d.x())
						.speed(0.3)
						.freq(3)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(-200, 200)
						.relativeVal(d.y())
						.speed(0.6)
						.freq(4)
						.currentStep(i)
					;
				}
			}
		)
		.requestAll()
	;

	/*
		Be wary when using these hints, they are there to help with z depth clipping issues.
		They can have performance issues when there's a lot of overlapping objects on screen.
	*/
	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);
}

void draw() {
	rect.loc( (int)random(width), (int)random(height));
	H.drawStage();

	//update the texture PGraphic
	g.beginDraw();
		g.clear();
		g.image(canvas.graphics(), 0, 0);
	g.endDraw();
}

