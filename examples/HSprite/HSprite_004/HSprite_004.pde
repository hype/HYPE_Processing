import hype.*;
import hype.extended.colorist.HPixelColorist;

HImage         clrSRC;
HPixelColorist clrHPC;
HRect          clrMarker;
int            clrMin = 0;
int            clrMax = 200;
color[]        clr;

HSprite        s1, s2, s3, s4, s5, s6, s7, s8, s9;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#FF3300).use3D(true);

	H.add( clrSRC = new HImage("color.png") ).loc(10, 10);
	clrHPC = new HPixelColorist(clrSRC);

	H.add(clrMarker = new HRect(2,10)).noStroke().fill(#CCCCCC).loc( 10,25);

	clr = new color[ clrMax ];

	for (int i = 0; i < clrMax; i++) {
		float tempPos = (clrSRC.width() / clrMax) * i;
		clr[i] = clrHPC.getColor(tempPos,0);
	}

	H.add(s1 = new HSprite(180,180).texture(new HImage("tex1.png"))).loc((width/2)-190, (height/2)-190).anchorAt(H.CENTER);
	H.add(s2 = new HSprite(180,180).texture(new HImage("tex2.png"))).loc((width/2), (height/2)-190).anchorAt(H.CENTER);
	H.add(s3 = new HSprite(180,180).texture(new HImage("tex3.png"))).loc((width/2)+190, (height/2)-190).anchorAt(H.CENTER);

	H.add(s4 = new HSprite(180,180).texture(new HImage("tex1.jpg"))).loc((width/2)-190, (height/2)).anchorAt(H.CENTER);
	H.add(s5 = new HSprite(180,180).texture(new HImage("tex2.jpg"))).loc((width/2), (height/2)).anchorAt(H.CENTER);
	H.add(s6 = new HSprite(180,180).texture(new HImage("tex3.jpg"))).loc((width/2)+190, (height/2)).anchorAt(H.CENTER);

	H.add(s7 = new HSprite(180,180).texture(new HImage("img1.jpg"))).loc((width/2)-190, (height/2)+190).anchorAt(H.CENTER);
	H.add(s8 = new HSprite(180,180).texture(new HImage("img2.jpg"))).loc((width/2), (height/2)+190).anchorAt(H.CENTER);
	H.add(s9 = new HSprite(180,180).texture(new HImage("img3.jpg"))).loc((width/2)+190, (height/2)+190).anchorAt(H.CENTER);
}

void draw() {
	H.drawStage();

	s1.fill( clr[clrMin] );
	s2.fill( clr[clrMin] );
	s3.fill( clr[clrMin] );
	s4.fill( clr[clrMin] );
	s5.fill( clr[clrMin] );
	s6.fill( clr[clrMin] );
	s7.fill( clr[clrMin] );
	s8.fill( clr[clrMin] );
	s9.fill( clr[clrMin] );

	// update color position

	clrMin++;
	if (clrMin == clrMax) clrMin = 0;
	float tempPos = ((clrSRC.width() / clrMax) * clrMin)+10;
	clrMarker.loc(tempPos,25);
}
