import hype.*;
import hype.extended.behavior.HOrbiter3D;
import hype.extended.colorist.HPixelColorist;

HOrbiter3D     orb1, orb2;
HCanvas        canvas;

HImage         clrSRC;
HPixelColorist clrHPC;
int            clrMin = 0;
int            clrMax = 200;
color[]        clr;

HRect          clrMarker, d;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( clrSRC = new HImage("color.png") ).loc(10, 10);
	clrHPC = new HPixelColorist(clrSRC);

	clrMarker = new HRect(2,10);
	clrMarker.noStroke().fill(#CCCCCC).loc( 10,25);
	H.add(clrMarker);

	clr = new color[ clrMax ];

	for (int i = 0; i < clrMax; i++) {
		float tempPos = (clrSRC.width() / clrMax) * i;
		clr[i] = clrHPC.getColor(tempPos,0);
	}

	canvas = new HCanvas(P3D).autoClear(false).fade(1);
	H.add(canvas);

	d = new HRect(50).rounding(4);
	d.noStroke().fill(#242424).anchorAt(H.CENTER).rotation(45);
	canvas.add(d);

	orb1 = new HOrbiter3D(width/2, height/2, 0)
		.zSpeed(-1.5)
		.ySpeed(-0.2)
		.radius(200)
	;

	orb2 = new HOrbiter3D(width/2, height/2, 0)
		.target(d)
		.zSpeed(5)
		.ySpeed(2)
		.radius(75)
		.parent(orb1)
	;
}

void draw() {
	H.drawStage();
	d.fill( clr[clrMin] );

	// update color position

	clrMin++;
	if (clrMin == clrMax) clrMin = 0;
	float tempPos = ((clrSRC.width() / clrMax) * clrMin)+10;
	clrMarker.loc(tempPos,25);
}
