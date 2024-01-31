import hype.*;
import hype.extended.behavior.HOscillator;

int cSize = 250;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	HCylinder c = new HCylinder();
	c
		.depth(cSize)
		.width(cSize)
		.height(cSize)
		.strokeWeight(2)
		.stroke(#CCCCCC, 225)
		.fill(#FF3300, 255)
		.loc(width/2, height/2)
	;

	c.topRadius(0.1);
	c.bottomRadius(0.6);

	H.add(c);

	new HOscillator().target(c).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(1);
	new HOscillator().target(c).property(H.ROTATIONY).range(-360, 360).speed(0.2).freq(1);
	new HOscillator().target(c).property(H.ROTATIONZ).range(-360, 360).speed(0.3).freq(1);
}

void draw() {
	lights();
	H.drawStage();
}
