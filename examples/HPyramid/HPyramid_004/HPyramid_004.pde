import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.behavior.HRotate;

HPyramid    pyr;
HOscillator oscT, oscB;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( pyr = new HPyramid() )
		.stroke(0)
		.fill(255)
		.size(200)
		.loc(width/2, height/2)
		.rotationX(-20)
	;

	new HRotate().target(pyr).speedY(0.75);

	oscT = new HOscillator().waveform(H.EASE).range(0, pyr.width()/2).speed(0.5).freq(2);
	oscB = new HOscillator().waveform(H.EASE).range(4, pyr.width()/4).speed(0.5).freq(2);
}

void draw() {
	lights();

	oscT.nextRaw();
	pyr.topRadius( (int)oscT.curr() );

	oscB.nextRaw();
	pyr.sides( (int)oscB.curr() );

	H.drawStage();
}
