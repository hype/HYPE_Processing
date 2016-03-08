
// need to fix HGroup + anchor

import hype.*;
import hype.extended.behavior.HRotate;

HGroup allBoxes;
HBox   boxX, boxY, boxZ;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( allBoxes = new HGroup() ).anchorAt(H.CENTER); // this would set anchor to width/2 + height/2

	allBoxes.add( boxX = new HBox() ).size(75).noStroke().fill(#FF3300).loc((width/2) - 175, height/2);
	allBoxes.add( boxY = new HBox() ).size(75).noStroke().fill(#FF3300).loc(width/2, height/2);
	allBoxes.add( boxZ = new HBox() ).size(75).noStroke().fill(#FF3300).loc((width/2) + 175, height/2);

	new HRotate().target(allBoxes).speedX(0).speedY(2).speedZ(0);
}

void draw() {
	lights();
	H.drawStage();
}
