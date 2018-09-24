import hype.*;
import hype.extended.behavior.HFollow;

HFollow mf;
HRect   rect;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);
	
	H.add(rect = new HRect(100).rounding(40)).strokeWeight(2).stroke(0,150).loc(width/2,height/2).anchorAt(H.CENTER).rotation(45);
	mf = new HFollow().target(rect).ease(0.01).spring(0.95).goal( new HVector(100,100,0) );
}

void draw() {
	H.drawStage();

	if(frameCount%20==0) mf.goal( new HVector( (int)random(width), (int)random(height), (int)random(-500,200) ) );
}


