import hype.*;
import hype.extended.behavior.HFollow;

HFollow mf;
HRect   rect, rectGoal;

void setup() {
	size(640,640);
	H.init(this).background(#242424);
	
	H.add(rect = new HRect(100).rounding(40)).strokeWeight(2).stroke(0,150).loc(width/2,height/2).anchorAt(H.CENTER).rotation(45);
	H.add(rectGoal = new HRect(25)).noStroke().fill(#FF3300).anchorAt(H.CENTER).loc(100,100).rotation(45);

	mf = new HFollow().target(rect).ease(0.01).spring(0.95).goal(rectGoal);
}

void draw() {
	H.drawStage();
}

void mousePressed() {
	rectGoal.loc(mouseX,mouseY);
}