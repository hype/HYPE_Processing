HDrawablePool pool;
HSwarm swarm;

int index, timerStart, timer;
int timerFire = 250;
int timerBase = timerFire;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	index = 0;
	timerStart = millis();

	final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

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
						.fill( colors.getColor() )
						.strokeWeight(2)
						.stroke(#000000, 100)
						.loc( width/2, height/2 )
						.anchorAt( H.CENTER )
					;

					// Add "d" to swarm's list of targets
					swarm.addTarget(d);
				}
			}
		)
	;
}

void draw() {
	timer = millis() - timerStart;
	if (timer >= timerFire) {
		if(!pool.isFull()){
			pool.request();
			index = pool.currentIndex() + 1;			
		}
	}
	timerFire = timerBase * index;

	// use the mouse as the swarm point
	if(H.mouseStarted()) {
		swarm.goal(mouseX,mouseY);
	}

	H.drawStage();
}
