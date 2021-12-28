import hype.*;
import hype.extended.behavior.HRotate;

int       cSize = 150;
HCylinder c1, c2, c3, c4, c5, c6;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	H.add( c1 = new HCylinder().texture("tex1.png").drawTop(false).drawBottom(false) );
	c1.depth(cSize).width(cSize).height(cSize*1.75).noStroke().fill(#FFFFFF, 255).loc((width/2)-200, (height/2)-150);

	H.add( c2 = c1.createCopy().texture("tex2.png") ).loc((width/2), (height/2)-150);
	H.add( c3 = c1.createCopy().texture("tex3.png") ).loc((width/2)+200, (height/2)-150);
	H.add( c4 = c1.createCopy().texture("tex4.png") ).loc((width/2)-200, (height/2)+150);
	H.add( c5 = c1.createCopy().texture("tex5.png") ).loc((width/2), (height/2)+150);
	H.add( c6 = c1.createCopy().texture("tex6.png") ).loc((width/2)+200, (height/2)+150);

	new HRotate().target(c1).speedX(0).speedY(1).speedZ(0);
	new HRotate().target(c2).speedX(0).speedY(1).speedZ(0);
	new HRotate().target(c3).speedX(0).speedY(1).speedZ(0);
	new HRotate().target(c4).speedX(0).speedY(1).speedZ(0);
	new HRotate().target(c5).speedX(0).speedY(1).speedZ(0);
	new HRotate().target(c6).speedX(0).speedY(1).speedZ(0);
}

void draw() {
	ortho();
	lights();
	hint(DISABLE_DEPTH_TEST);
	H.drawStage();
}
