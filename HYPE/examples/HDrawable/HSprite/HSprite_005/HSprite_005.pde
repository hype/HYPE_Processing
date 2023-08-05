import hype.*;
import hype.extended.behavior.HOrbiter3D;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;

int           stageW = 900;
int           stageH = 900;
int           w, h;
color         clrBg = #242424;
String        pathToData = "../data/";

// **************************************************

// SPRITES

PImage[]      tex = new PImage[3];

int           numAssets = 400;
HSprite[]     s = new HSprite[numAssets];
int           spriteSize   = 100;

// **************************************************

// ANIMATION BEHAVIORS

HOrbiter3D[]  orb  = new HOrbiter3D[numAssets];

HOscillator[] oscR = new HOscillator[numAssets];
HOscillator[] oscS = new HOscillator[numAssets];

// **************************************************

// COLOR

HColorPool    colors;

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = width/2;
	h = height/2;

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC, #999999, #666666, #4D4D4D, #333333, #FF3300, #FF6600);

	for (int i = 0; i < tex.length; ++i) {
		tex[i] = loadImage(pathToData + "tex" + (i+1) + ".png"); // tex[0] = tex1.png, tex[1] = tex2.png, tex[2] = tex3.png
	}

	for (int i = 0; i < numAssets; ++i) {
		s[i] = new HSprite();
		s[i].texture( tex[ (int)random(tex.length) ] ); // get a random texture, tex[0] = tex1.png, tex[1] = tex2.png, tex[2] = tex3.png
		s[i].size(spriteSize);                          // set the size of the sprite
		s[i].anchorAt(H.CENTER);                        // set the anchor point of the sprite
		s[i].noStroke();                                // turn off the stroke
		s[i].fill( colors.getColor() );                 // set the fill color of the sprite / use a random color from the HColorPool
		s[i].loc(0,0);

		orb[i] = new HOrbiter3D(w, h, 0);
		orb[i].radius(225);
		orb[i].ySpeed(1);
		orb[i].zSpeed(1);
		orb[i].yAngle( (i+1)*2 );
		orb[i].zAngle( (i+1)*3 );

		oscS[i] = new HOscillator().range(0.1, 1.0).speed(0.1).freq(10);
	}
}

void draw() {
	background(clrBg);
	noTint();

	for (int i = 0; i < numAssets; ++i) {
		orb[i].run();
		oscS[i].run();
		s[i].loc( orb[i].x(), orb[i].y() ).scale( 0.99 ).draw(this.g);
		// s[i].loc( orb[i].x(), orb[i].y() ).width(100).height(100).scale( 0.999 ).draw(this.g);
	}

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, h, width, h);
	line(w, 0, w, height);

// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
