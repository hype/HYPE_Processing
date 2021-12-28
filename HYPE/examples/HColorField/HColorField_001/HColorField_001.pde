import hype.*;
import hype.extended.colorist.HColorField;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
HColorField   colorField;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colorField = new HColorField(width, height)
		.addPoint(0,     height/2, #FF0066, 0.5f)
		.addPoint(width, height/2, #3300FF, 0.5f)
		.fillOnly()
		// .strokeOnly()
		// .fillAndStroke()
	;

	pool = new HDrawablePool(10000);
	pool.autoAddToStage()
		.add(new HRect())
		.layout(new HGridLayout().startX(20).startY(20).spacing(6,6).cols(100))
		.onCreate(
			new HCallback(){
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(#000000).size(5);
					
					colorField.applyColor(d);
				}
			}
		)
		.requestAll()
	;

	H.drawStage();
	noLoop();
}

void draw() {

}
