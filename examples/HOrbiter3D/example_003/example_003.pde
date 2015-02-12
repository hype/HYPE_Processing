void setup() {
	size(640, 640, P3D);
	H.init(this).background(#202020);
	smooth();

	HCanvas c = new HCanvas(P3D).autoClear(false).fade(1);
	H.add(c);

	HRect r = new HRect().rounding(4);
	r
		.fill( #FF4400 )
		.anchorAt(H.CENTER)
		.rotation( 45 )
		.size(45)
	;
	c.add(r);

	HOrbiter3D o = new HOrbiter3D(width/2, height/2, 0)
		.zSpeed(1)
		.ySpeed(0.1)
		.radius(250)
	;

	HOrbiter3D o2 = new HOrbiter3D()
		.target(r)
		.zSpeed(5)
		.ySpeed(1)
		.radius(75)
		.parent(o)
	;

}

void draw() {
	H.drawStage();
}
