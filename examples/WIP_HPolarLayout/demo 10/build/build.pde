HDrawablePool pool;
HPolarLayout layout;
HColorPool colors;

float ranSeedNum = 1;
int boxDepth = 60;

void setup(){
	size(640,640,P3D);
	H.init(this).background(#000000).use3D(true).autoClear(true);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC, #999999, #666666, #4D4D4D, #333333, #242424, #202020, #111111, #080808, #000000);

	layout = new HPolarLayout(0.7, 0.1, width / 2, height / 2, false, 0.01);

	pool = new HDrawablePool( 600 );
	pool.autoAddToStage()
		.add ( new HBox() )
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HBox d = (HBox) obj;
					d
						.depth(boxDepth)
						.width(boxDepth)
						.height(boxDepth)
						// .anchor(boxDepth/2,0)
					;

					layout.applyLayout(d);

					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(-360, 360)
						.speed(0.05)
						.freq(3)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(-900, 100)
						.speed(1)
						.freq(1)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(-360, 360)
						.speed(0.3)
						.freq(1)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-360, 360)
						.speed(0.3)
						.freq(1)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(-360, 360)
						.speed(0.5)
						.freq(1)
						.currentStep(i*2)
					;
				}
			}
		)
		.requestAll()
	;
}
 
void draw(){

	pointLight(255, 51, 0,  0, height/2, -100);        // orange
	pointLight(0, 149, 168,  width, height/2, -100);   // teal
	pointLight(255, 204, 0,  width/2, height/2, 0); // yellow

	int i = 0;

	for (HDrawable d : pool) {
		d.noStroke().fill( colors.getColor(i * (int)ranSeedNum) );
		++i;
	}

	ranSeedNum += 0.5;
	if (ranSeedNum>300) ranSeedNum = 1;

	H.drawStage();
}

