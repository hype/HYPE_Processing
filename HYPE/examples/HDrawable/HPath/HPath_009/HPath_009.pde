import hype.*;
import hype.extended.colorist.HColorField;
import hype.extended.layout.HGridLayout;

int         stageW = 900;
int         stageH = 900;
int         w, h;
color       clrBg  = #242424;

// **************************************************

HColorField colorField;

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

	colorField = new HColorField(width, height)
		.addPoint(w-275, h-275, #FF0000, 0.5) // x, y, color, gradient radius
		.addPoint(w+275, h-275, #00FF00, 0.5)
		.addPoint(w-275, h+275, #FFFF00, 0.5)
		.addPoint(w+275, h+275, #0000FF, 0.5)
	;

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
		s[i].vertexColors(colorField);
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
