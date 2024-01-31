import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

int         stageW = 900;
int         stageH = 900;
int         w, h;
color       clrBg  = #242424;

// **************************************************

HColorPool  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #00616F, #0095A8, #FF3300, #FF6600);

int         gridC = 7;
int         gridR = 7;

int         gridSpacingX = 115;
int         gridSpacingY = 115;

int         gridStartX = -(gridSpacingX * (gridC-1))/2;
int         gridStartY = -(gridSpacingY * (gridR-1))/2;

int         numAssets = gridC * gridR;
HPath[]     d = new HPath[numAssets];

int         sSize = 100;

HGridLayout layout = new HGridLayout().startX(gridStartX).startY(gridStartY).spacing(gridSpacingX, gridSpacingY).cols(gridC).rows(gridR);

// **************************************************

void settings() {
	size(stageW, stageH, P3D);
	// fullScreen();
}

void setup() {
	H.init(this);
	background(clrBg);

	w = stageW/2;
	h = stageH/2;

	for (int i = 0; i < numAssets; ++i) {
		PVector pt = layout.getNextPoint();

		int   ranEdges = round(random(5, 10));
		float ranDepth = random(0.25, 0.75);

		d[i] = new HPath();
		d[i].star( ranEdges, ranDepth );
		d[i].size(sSize);
		d[i].strokeWeight(0);
		d[i].noStroke();
		d[i].fill( colors.getColor() );
		d[i].anchor( (sSize/2), (sSize/2) );
		d[i].rotation( (int)random(360) );
		d[i].loc(w-pt.x, h-pt.y);
	}
}

void draw() {
	background(clrBg);

	for (int i = 0; i < numAssets; ++i) {
		d[i].draw(this.g);
	}

	visualizeHelper();
}

// **************************************************

void visualizeHelper() {

	// visualize the center of the stage

	strokeWeight(1);
	stroke(#666666);
	noFill();
	line(0, h, stageW, h);
	line(w, 0, w, stageH);

	// keep track of the FPS in the title bar

	surface.setTitle(
		"FPS: " + (int)frameRate
	);
}
