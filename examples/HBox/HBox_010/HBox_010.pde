import hype.*;
import hype.extended.behavior.HOscillator;

HDrawablePool pool;
HImage i1, i2, i3, i4, i5, i6;

int boxSize = 400;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);
	lights();

	i1 = new HImage("tex1.png");
	i2 = new HImage("tex2.png");
	i3 = new HImage("tex3.png");
	i4 = new HImage("tex4.png");
	i5 = new HImage("tex5.png");
	i6 = new HImage("tex6.png");

	HBox b = new HBox();
	b.noStroke();
	b.textureTop(i1);
	b.textureBottom(i2);
	b.textureFront(i3);
	b.textureBack(i4);
	b.textureRight(i5);
	b.textureLeft(i6);

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
	H.drawStage();
}

