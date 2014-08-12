HSwarm swarm;
HDrawablePool pool, swarmPool;
HMagneticField field;
HColorPool colors;

void setup() {
	size(640,640);

	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC).fillOnly();

	field = new HMagneticField()
		.addPole(width/2, height/2,  2) // x, y, north polarity / repel
		.addPole(width/2, height/2,  2) // x, y, north polarity / repel

		.addPole(width/2, height/2, -2) // x, y, south polarity / attract
		.addPole(width/2, height/2, -2) // x, y, south polarity / attract
	;

	pool = new HDrawablePool(930);
	pool.autoAddToStage()
		.add(
			new HShape("arrow.svg")
			.enableStyle(false)
			.anchorAt(H.CENTER)
		)

		.colorist(colors)

		.layout(
			new HGridLayout()
			.startX(5)
			.startY(15)
			.spacing(21,21)
			.cols(31)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.noStroke();
					field.addTarget(d);
				}
			}
		)

		.requestAll()
	;

	swarm = new HSwarm()
		.addGoal(width/2,height/2)
		.speed(7)
		.turnEase(0.04)
		.twitch(20)
	;

	swarmPool = new HDrawablePool(4);
	swarmPool.autoAddToStage()
		.add (new HRect(10).rounding(5))
		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.strokeWeight(2)
						.stroke(#FFFFFF)
						.fill( #000000 )
						.loc( (int)random(100,540), (int)random(100,540) )
						.anchorAt( H.CENTER )
					;

					swarm.addTarget(d);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	int i = 0;
	for (HDrawable d : swarmPool) {

		if(i<2) d.fill(#FF3300); // repel   = red
		else    d.fill(#237D26); // attract = green

		HMagneticField.HPole p = field.pole(i);
		p._x = d.x();
		p._y = d.y();

		++i;

	}


	H.drawStage();
}

