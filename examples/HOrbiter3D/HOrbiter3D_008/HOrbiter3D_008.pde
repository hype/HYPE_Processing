HOrbiter3D orb1, orb2;
HCanvas canvas;

HImage colorSRC;
HPixelColorist hpc;

color[] c1;
int[]   c1Nums;
int     c1min = 0;
int     c1Max = 200;

HTimer timerColor;

HRect d, colorRun;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#202020).autoClear(true).use3D(true);
	smooth();

	hpc = new HPixelColorist("color.png");
	H.add( colorSRC = new HImage("color.png") ).loc(10, 10);

	colorRun = new HRect(2,10);
	colorRun.noStroke().fill(#CCCCCC).loc( 10,25);
	H.add(colorRun);

	c1 = new color[ c1Max ];

	for (int i = 0; i < c1Max; i++) {
		float tempPos = (colorSRC.width() / c1Max) * i;
		c1[i] = hpc.getColor(tempPos,0);
	}

	timerColor = new HTimer()
		.interval(20)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					c1min++;
					if (c1min == c1Max) c1min = 0;

						float tempPos = ((colorSRC.width() / c1Max) * c1min)+10;
						colorRun.loc( tempPos,25);
				}
			}
		)
	;

	canvas = new HCanvas(P3D).autoClear(false).fade(1);
	H.add(canvas);

	d = new HRect(50).rounding(4);
	d
		.noStroke()
		.fill(#FF3300)
		.anchorAt(H.CENTER)		
		.rotation(45)
	;
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

	d.fill( c1[c1min] );
}
