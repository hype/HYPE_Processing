import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HMagneticField;
import hype.extended.behavior.HSwarm;

HDrawablePool  pool, poolSwarm;
HMagneticField field;
HSwarm         swarm;
int            numMagnets = 10;

void setup() {
	size(640,640);
	H.init(this).background(#000000);

	field = new HMagneticField();

	for (int i = 0; i<numMagnets; i++){
		if ( (int)random(2) == 0 ) field.addPole( (int)random(width), (int)random(height),   3); // x, y, north polarity / strength =  3 / repel
		else                       field.addPole( (int)random(width), (int)random(height),  -3); // x, y, south polarity / strength = -3 / attract
	}

	pool = new HDrawablePool(2500);
	pool.autoAddToStage()
		.add(new HShape("arrow.svg").enableStyle(false).anchorAt(H.CENTER))
		.layout(new HGridLayout().startX(-60).startY(-60).spacing(16,16).cols(50))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().anchor(-20,-20);
					field.addTarget(d);
				}
			}
		)
		.requestAll()
	;

	swarm = new HSwarm().addGoal(width/2,height/2).speed(7).turnEase(0.03).twitch(20);

	poolSwarm = new HDrawablePool(numMagnets);
	poolSwarm.autoAddToStage()
		.add(new HRect(5))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().noFill().loc( (int)random(width), (int)random(height) ).visibility(false);
					swarm.addTarget(d);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	int i = 0;

	for (HDrawable d : poolSwarm) {
		HMagneticField.HPole p = field.pole(i);
		p.x = d.x();
		p.y = d.y();
		++i;
	}

	H.drawStage();
}
