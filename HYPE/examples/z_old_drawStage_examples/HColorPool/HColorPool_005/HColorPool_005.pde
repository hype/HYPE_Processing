import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HRotate;

HDrawablePool pool;
HColorPool    colors;
int           colorIndex = 0;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	colors = new HColorPool(#FFFFFF, #333333, #0095a8, #FF3300);

	pool = new HDrawablePool(200);
	pool.autoAddToStage()
		.add(new HRect().rounding(10))
		.add(new HEllipse(), 25)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill( colors.getColorAt(colorIndex) ) // select a color at a specific index in the HColorPool / 0 = #FFFFFF
						.loc( (int)random(width), (int)random(height) )
						.anchor( new PVector(25,25) )
						.rotation( (int)random(360) )
						.size( 25+((int)random(3)*25) )
					;

					HRotate r = new HRotate();
					r.target(d).speed( random(-4,4) );
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();

	for (HDrawable d: pool) {
		d.fill( colors.getColorAt(colorIndex) );
	}
}

void keyPressed() {
	switch (key) {
		case ' ':
			colorIndex = ++colorIndex%colors.size(); // press the spacebar on your keyboard to cycle through the colors
		break;
	}
}
