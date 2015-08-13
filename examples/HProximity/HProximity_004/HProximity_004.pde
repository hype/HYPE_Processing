import hype.*;

HDrawablePool pool;
HColorField colorField;

void setup() {
	size(640, 640);
	H.init(this).background(#202020);

	colorField = new HColorField(width, height)
      .addPoint(0, height/2, #FF0066, 0.5f)
      .addPoint(width, height/2, #3300FF, 0.5f)
      .fillOnly()
    ;

	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add( new HRect(25) )

		.layout(
			new HGridLayout()
				.startX(20)
				.startY(20)
				.spacing(26, 26)
				.cols(24)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(#000000).anchorAt(H.CENTER);

					colorField.applyColor(d);
            		
            		new HProximity()
            			.target(d)
            			.property(HConstants.SIZE)
            			.min(5)
            			.max(50)
            			.spring(0.99)
            			.ease(0.1)
            		;
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
