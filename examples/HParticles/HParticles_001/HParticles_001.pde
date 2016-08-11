import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool        pool;
HColorPool           colors;
HParticles           particleEngine;
float                rotation = 0; //for camera
boolean              useCamera=false;
HBox                 bx; 

//press the space bar to mix things up!
//try moving mouse up/down and left/right to update particle animation speed

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();
	lights();
	sphereDetail(2);

	particleEngine = new HParticles().fade(true).minimumLife(20).maximumLife(150).speed(1.2).decay(0.5);
	colors = new HColorPool().add(#FFFFFF, 9).add(#ECECEC, 9).add(#CCCCCC, 9).add(#333333, 3).add(#0095a8, 2).add(#00616f, 2).add(#FF3300).add(#FF6600);

	pool = new HDrawablePool(400);
	pool.autoAddToStage()
	.add (
		new HSphere()
			.stroke(255)
			.size(5)
		)
	//.add(new HText("0"))
	//.add(new HText("1"))

	.onCreate(
		new HCallback() {
			public void run(Object obj) {
				HDrawable d = (HDrawable) obj;
				colors.applyColor(d);
				particleEngine.addParticle(d);
			}
		}
	)
	.requestAll();

	bx = new HBox();
	bx.size(200).x(width/2).y(height/2).fill(255, 50);
	H.add(bx);
}


void draw() {

	lights();
	ambientLight(127, 127, 127);

	bx.alpha(0);
	camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0); //default camera 

	if (useCamera) {
		bx.alpha(50);
		float orbitRadius = 660;
		float xpos = cos(radians(rotation)) * orbitRadius;
		float zpos = sin(radians(rotation)) * orbitRadius;
		camera(xpos, 0, zpos, width/2, height/2, 0, 0, -1, -1);
		rotation += 0.7;
	}

	H.drawStage();

	particleEngine.location(mouseX, mouseY);
	particleEngine.speed(map(mouseY, 0, height, 1, 10));
	particleEngine.decay(map(mouseX, 0, width, 10, 1));
	println("particle speed is " + particleEngine.speed());
	println("particle decay is " + particleEngine.decay());
}

void keyPressed() {
	if (key == ' ') {
		if (useCamera) {
			useCamera = false;
		} else {
			useCamera = true;
		}
	}
}
