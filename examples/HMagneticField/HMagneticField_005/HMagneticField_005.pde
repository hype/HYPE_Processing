import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HMagneticField;
import hype.extended.behavior.HSwarm;

HDrawablePool  pool, poolSwarm;
HMagneticField field;
HSwarm         swarm;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	field = new HMagneticField()
		.addPole(width/2, height/2,  2) // x, y, north polarity / repel
		.addPole(width/2, height/2,  2) // x, y, north polarity / repel
		.addPole(width/2, height/2, -2) // x, y, south polarity / attract
		.addPole(width/2, height/2, -2) // x, y, south polarity / attract
	;

	pool = new HDrawablePool(930);
	pool.autoAddToStage()
		.add(new HShape("arrow.svg").enableStyle(false).anchorAt(H.CENTER))
		.layout(new HGridLayout().startX(5).startY(15).spacing(21,21).cols(31))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke().fill(255);
					field.addTarget(d);
				}
			}
		)
		.requestAll()
	;

	swarm = new HSwarm().addGoal(width/2,height/2).speed(7).turnEase(0.04).twitch(20);

	poolSwarm = new HDrawablePool(4);
	poolSwarm.autoAddToStage()
		.add(new HRect(10).rounding(5))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.strokeWeight(2).stroke(#FFFFFF).fill( #000000 ).loc( (int)random(width), (int)random(height) ).anchorAt( H.CENTER );
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
		if(i<2) d.fill(#FF3300); // repel   = red
		else    d.fill(#237D26); // attract = green

		HMagneticField.HPole p = field.pole(i);
		p.x = d.x();
		p.y = d.y();

		++i;
	}

	H.drawStage();
}
