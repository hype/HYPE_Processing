import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool     pool;
HBox              b;
HScreenshot       rec;
boolean           isRecording = false;
float             rotation = 12; //for camera

HColorPool colors;

int r=200;

void setup() {
	size(640, 640, P3D); 
	H.init(this).background(#202020).use3D(true);
	smooth();

	rec = new HScreenshot().filename("render"); //screenshots will be saved in a sequence as render00001.png, render00002 etc

	colors = new HColorPool().add(#FFFFFF, 9).add(#ECECEC, 9).add(#CCCCCC, 9).add(#333333, 3).add(#0095a8, 2).add(#00616f, 2).add(#FF3300).add(#FF6600);

	pool = new HDrawablePool(500);

	b = new HBox();
	pool.add(b);

	pool.autoAddToStage()
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable3D d = (HDrawable3D) obj;
					d.stroke(0).size(5).loc(random(width),random(height),random(-200,0)); //randomly place items
					colors.applyColor(d);
				}
			}
		)
		.requestAll();
}

void draw() {
	float orbitRadius = 660;
	float xpos = cos(radians(rotation)) * orbitRadius;
	float zpos = sin(radians(rotation)) * orbitRadius;
	camera(xpos, 0, zpos, width/2, height/2, 0, 0, -1, -1);
	rotation -= 1.2;

	H.drawStage();
	
	saveScreen();
} 

void saveScreen() {
	if(isRecording){  
		rec.run();
	}
}

void keyPressed() {
	if (key == ' ' && isRecording==false) {
		println("save screenshots");
		//after spacebar is pressed, will save screenshots every 3 frames
		//then exit after 200 frames in total have elapsed
		//this example will result in approximately 66 screenshots being saved
		rec.start(frameCount).end(frameCount+200).frequency(3).exit(true);
		isRecording=true;
	}
}
