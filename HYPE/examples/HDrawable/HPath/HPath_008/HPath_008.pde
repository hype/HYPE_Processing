import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

int         stageW = 900;
int         stageH = 900;
int         w, h;
color       clrBg  = #242424;

// **************************************************

HColorPool  colors = new HColorPool(#006600, #009900, #00CC00, #00616F, #0095A8, #FF3300, #FF6600, #FF9900);

int         gridC = 7;
int         gridR = 7;

int         gridSpacingX = 115;
int         gridSpacingY = 115;

int         gridStartX = -(gridSpacingX * (gridC-1))/2;
int         gridStartY = -(gridSpacingY * (gridR-1))/2;

int         numAssets = gridC * gridR;
HPath[]     s = new HPath[numAssets];

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

	w = width/2;
	h = height/2;

	for (int i = 0; i < numAssets; ++i) {
		PVector pt = layout.getNextPoint();

		int   ranEdges = round(random(5, 10));
		float ranDepth = random(0.25, 0.75);

		s[i] = new HPath();
		s[i].star( ranEdges, ranDepth );
		s[i].size(sSize);
		s[i].strokeWeight(0);
		s[i].noStroke();
		s[i].fill(#000000);
		s[i].vertexColors(colors);
		s[i].anchor( (sSize/2), (sSize/2) );
		s[i].rotation( (int)random(360) );
		s[i].loc(w+pt.x, h+pt.y);
	}
}

void draw() {
	background(clrBg);

	for (int i = 0; i < numAssets; ++i) {
		s[i].draw(this.g);
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
