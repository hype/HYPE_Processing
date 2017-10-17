import hype.*;
import hype.extended.behavior.HOscillator;

float size = 500;
float cylinderHeight = 500;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	HCylinder c1 = new HCylinder();
	
	HCylinder c2 = new HCylinder();
	c2.texture("tex1.png");

	H.add(c1);
	H.add(c2);

	//solid orange cylinder
	c1.depth(size).width(size).height(cylinderHeight).strokeWeight(2).stroke(0).fill(#ff3300).x(width/2).y(height/2).z(-500);
	c1.strokeSides(false);
	c1.noStroke();

	//transparent white texture tube, same height as above, but greater width/depth
	c2.depth(size*1.2).width(size*1.2).height(cylinderHeight).fill(255,100).x(width/2).y(height/2).z(-500);
	c2.drawTop(false);
	c2.drawBottom(false);
	c2.noStroke();


	new HOscillator().target(c1).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(1);
	new HOscillator().target(c1).property(H.ROTATIONY).range(-360, 360).speed(0.2).freq(1);
	new HOscillator().target(c1).property(H.ROTATIONZ).range(-360, 360).speed(0.3).freq(1);

	new HOscillator().target(c2).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(1);
	new HOscillator().target(c2).property(H.ROTATIONY).range(-360, 360).speed(0.2).freq(1);
	new HOscillator().target(c2).property(H.ROTATIONZ).range(-360, 360).speed(0.3).freq(1);

}

void draw() {
	/*
		Be wary when using these hints, they are there to help with z depth clipping issues.
		They can have performance issues when there's a lot of overlapping objects on screen.
	*/
	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	lights();
	H.drawStage();
}
