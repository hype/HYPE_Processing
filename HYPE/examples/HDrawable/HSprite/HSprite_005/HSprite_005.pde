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

int           numAssets = 360;
HSprite[]     d = new HSprite[numAssets];
int           spriteSize   = 100;

// **************************************************

// ANIMATION BEHAVIORS

HOrbiter3D[]  orb  = new HOrbiter3D[numAssets];

HOscillator[] oscS = new HOscillator[numAssets];
HOscillator[] oscR = new HOscillator[numAssets];

// **************************************************

// COLOR

HColorPool    colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC, #999999, #666666, #4D4D4D, #333333, #FF3300, #FF6600);

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

	for (int i = 0; i < tex.length; ++i) {
		tex[i] = loadImage(pathToData + "tex" + (i+1) + ".png"); // tex[0] = tex1.png, tex[1] = tex2.png, tex[2] = tex3.png
	}

	for (int i = 0; i < numAssets; ++i) {
		d[i] = new HSprite();
		d[i].texture( tex[ (int)random(tex.length) ] );    // get a random texture, tex[0] = tex1.png, tex[1] = tex2.png, tex[2] = tex3.png
		d[i].size(spriteSize);                             // set the size of the sprite
		d[i].anchorAt(H.CENTER);                           // set the anchor point of the sprite
		d[i].noStroke();                                   // turn off the stroke
		d[i].fill( colors.getColorAt( i%colors.size() ) ); // set the fill color of the sprite / use modulo to loop through the colors
		d[i].loc(0,0);

		orb[i] = new HOrbiter3D(w, h, 0);                  // create 360 HOrbiter3D objects, set x,y,z to the center of the stage
		orb[i].radius(300); 			                   // set the radius of the orbit
		orb[i].ySpeed(0.5); 			                   // set the y speed of the orbit
		orb[i].zSpeed(0.5); 			                   // set the z speed of the orbit
		orb[i].yAngle( (i+1)*2 ); 		                   // set the y angle of the orbit // this creates an y offset for each sprite
		orb[i].zAngle( (i+1)*3 ); 		                   // set the z angle of the orbit // this creates an z offset for each sprite

		oscS[i] = new HOscillator().range(0.1, 1.0).speed(0.1).freq(10).currentStep(i*0.6);
		oscR[i] = new HOscillator().range(-180, 180).speed(0.1).freq(10).currentStep(i*0.3);
	}
}

void draw() {
	background(clrBg);
	noTint();

	for (int i = 0; i < numAssets; ++i) {
		orb[i].run();
		oscS[i].run();
		oscR[i].run();
		d[i].loc( orb[i].x(), orb[i].y(), orb[i].z() ).rotation( oscR[i].cur() ).size(spriteSize).scale( oscS[i].cur() ).draw(this.g);
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


