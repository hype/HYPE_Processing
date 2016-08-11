import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool      pool;
HColorPool         colors;
HParticles         particleEngine;
HImage             i1;
HSprite            s1;
HCanvas            canvas;
HTimer             timer;
HSwarm             swarm;
HRect              sp;
HRotate            r1;

// Particles meets and marries HCanvas
// Swarm drives particle positions
// Individual particles are an image (HSprite)
// Plus some HRotations for good measure..

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();

	particleEngine = new HParticles().fade(false).minimumLife(180).maximumLife(250).speed(1.2).decay(2.1);
	colors = new HColorPool().add(#FFFFFF, 9).add(#ECECEC, 9).add(#CCCCCC, 9).add(#333333, 3).add(#0095a8, 2).add(#00616f, 2).add(#FF3300).add(#FF6600);

	i1 = new HImage("flare.png");
	s1 = new HSprite(i1.width(), i1.height()).texture(i1.image()); //new HSprite object - thanks to Mr Benjamin Fox

	canvas = new HCanvas(P3D).autoClear(false).fade(5);
	H.add(canvas);

	swarm = new HSwarm()
		.addGoal(width/2, height/2)
		.speed(4)
		.turnEase(0.05f)
		.twitch(25);

	sp = new HRect(10);
	sp.loc(random(width), random(height)).fill(H.RED);
	sp.visibility(false); //hide the swarm item, set to true if you wanna see it

	swarm.addTarget(sp);
	canvas.add(sp);

	pool = new HDrawablePool(800);
	pool.autoParent(canvas)
		.add(s1.size(20).anchorAt(H.CENTER)) 
		//.add(s1.size(20).anchor(-100,-100)) //you can also try something like .anchor(-100,-100)) for something a bit different 
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					colors.applyColor(d);
					particleEngine.addParticle(d);
					r1 = new HRotate().speedY(3).speedX(2).speedZ(-2); //you'll also need to grab an updated version of HRotate that does x, y and z rotations
					r1.target(d); //comment out for a more traditonal firework-ish effect
				}
			}
		);

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(5) //gradually release particle items
		.callback(
			new HCallback() {
				public void run(Object obj) {
					pool.request();
				}
			}
		);
}


void draw() {

	H.drawStage();

	// update particle location based on swarm position
	// updated every 10 frames
	if (frameCount%10==0) { 
		particleEngine.location(sp.loc());
	}
	
		
}
