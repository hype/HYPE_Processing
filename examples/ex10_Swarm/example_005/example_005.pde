HDrawablePool pool;
HSwarm swarm;
HColorField colors;
HTimer timer;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	colors = new HColorField(width, height)
	    .addPoint(0, height/2, #FF0066, 0.5f)
	    .addPoint(width, height/2, #3300FF, 0.5f)
	    .fillOnly()
	    // .strokeOnly()
	    // .fillAndStroke()
    ;

	swarm = new HSwarm()
		.goal(width/2,height/2)
		.speed(5)
		.turnEase(0.05f)
		.twitch(20)
	;

	pool = new HDrawablePool(40);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
		)
		.setOnCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d
						.size((int)random(10,20), (int)random(2,6) )
						.fill( #000000 )
						.strokeWeight(2)
						.stroke(#000000, 100)
						.loc( width/2, height/2 )
						.anchorAt( H.CENTER )
					;
					colors.applyColor( d );

					// Add "d" to swarm's list of targets
					swarm.addTarget(d);
				}
			}
		)
	;

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(250)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					pool.request();
				}
			}
		)
	;
}

void draw() {
	HIterator<HDrawable> it = pool.iterator();
	while(it.hasNext()) {
		HDrawable d = it.next();

		d.fill(#000000).stroke(#000000, 100);
		colors.applyColor(d);
	}

    if(H.mouseStarted()) {
      swarm.goal(mouseX,mouseY);
    }

	H.drawStage();
}