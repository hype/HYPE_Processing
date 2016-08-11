import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool     pool;
HSphereLayout     layout;
HBox              b;        
HColorPool        colors;
float             rotation = 12; //for camera
PVector           centre, mid;
HOscillator       xO, yO, zO;

void setup() {
	size(640, 640, P3D); 
	H.init(this).background(#202020).use3D(true);
	smooth();

	colors = new HColorPool().add(#FFFFFF, 9).add(#ECECEC, 9).add(#CCCCCC, 9).add(#333333, 3).add(#0095a8, 2).add(#00616f, 2).add(#FF3300).add(#FF6600);
	pool = new HDrawablePool(5000);
	layout = new HSphereLayout().radius(200).detail(5);

	b = new HBox();
	pool.add(b);

	pool.layout(layout); //apply the layout

	pool.autoAddToStage()
	.onCreate (
		new HCallback() {
			public void run(Object obj) {
				HDrawable3D d = (HDrawable3D) obj;
				int i = pool.currentIndex()+1;
				colors.applyColor(d);
				d.noStroke().size(5);

				// get vector at 75% of normal position 
				PVector centre = new PVector (layout.offsetX(), layout.offsetY(), layout.offsetZ());
				PVector mid = d.loc().sub(centre);
				mid.normalize();
				mid.mult(layout.radius()*0.75);
				mid.add(centre);

				//use oscillators to make our sphere compress/decompress
				xO = new HOscillator().target(d).property(H.X).range(d.x(), mid.x).speed(1).freq(3);
				yO = new HOscillator().target(d).property(H.Y).range(d.y(), mid.y).speed(2).freq(10);
				zO = new HOscillator().target(d).property(H.Z).range(d.z(), mid.z).speed(1.5).freq(15);
			}
		}
	)
	.requestAll();
}

void draw() {
	lights();
	ambientLight(127, 127, 127);

	float orbitRadius = 660;
	float xpos = cos(radians(rotation)) * orbitRadius;
	float zpos = sin(radians(rotation)) * orbitRadius;
	camera(xpos, 0, zpos, width/2, height/2, 0, 0, -1, -1);
	//rotation += 1.7;

	H.drawStage();
} 
