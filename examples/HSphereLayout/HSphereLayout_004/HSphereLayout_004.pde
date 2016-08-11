import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool     pool;
HSphereLayout     layout;
HColorPool        colors;
float             rotation = 0; //for camera

void setup() {
	size(640, 640, P3D); 
	H.init(this).background(#202020).use3D(true);
	smooth();

	colors = new HColorPool().add(#FFFFFF, 9).add(#ECECEC, 9).add(#CCCCCC, 9).add(#333333, 3).add(#0095a8, 2).add(#00616f, 2).add(#FF3300).add(#FF6600);
	pool = new HDrawablePool(5000);
	layout = new HSphereLayout().radius(200).detail(6).thetaAngles(180,360).phiAngles(40,140); 
	// here we adjust the angles - to create a hemisphere with the ends 'cut off'
	pool.add(new HText("0"));
	pool.add(new HText("1"));
	
	pool.layout(layout); //apply the layout

	pool.autoAddToStage()
	.onCreate (
		new HCallback() {
			public void run(Object obj) {
				HDrawable d = (HDrawable) obj;
				d.stroke(0).size(20);
				colors.applyColor(d);
			}
		}
	)
	.requestAll();
}

void draw() {

	ambientLight(127, 127, 127);
	pointLight(51, 153, 153, width/2, -50, 150);            
	pointLight(204, 204, 204, width/2, (height/2) - 50, 500); 

	float orbitRadius = 700;
	float xpos = cos(radians(rotation)) * orbitRadius;
	float zpos = sin(radians(rotation)) * orbitRadius;
	camera(xpos, 0, zpos, width/2, height/2, 0, 0, -1, -1);
	rotation += 1.5;

	H.drawStage();
	
} 
