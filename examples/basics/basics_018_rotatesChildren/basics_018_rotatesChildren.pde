import hype.*;
import hype.extended.behavior.HRotate;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HDrawable r = new HRect(20).rounding(2).noStroke().anchorAt(H.CENTER);

	HDrawable d1 = H.add(new HRect(50).rounding(4)).noStroke().fill(#00616f).anchorAt(H.CENTER).loc(width/5,height/2);
	d1.add(r.createCopy()).fill(#FF3300).locAt(H.TOP_LEFT);
	d1.add(r.createCopy()).fill(#FF3300).locAt(H.BOTTOM_RIGHT);

	HDrawable d2 = H.add(new HRect(50).rounding(4)).noStroke().fill(#0095a8).anchorAt(H.CENTER).loc(width*2/5,height/2);
	d2.add(r.createCopy()).fill(#FF6600).locAt(H.TOP_LEFT);
	d2.add(r.createCopy()).fill(#FF6600).locAt(H.BOTTOM_RIGHT);

	HDrawable grp1 = H.add(new HGroup()).size(50).anchorAt(H.CENTER).loc(width*3/5,height/2);
	grp1.add(r.createCopy()).fill(#FF9900).locAt(H.TOP_LEFT);
	grp1.add(r.createCopy()).fill(#FF9900).locAt(H.BOTTOM_RIGHT);

	HDrawable grp2 = H.add(new HGroup()).size(50).anchorAt(H.CENTER).loc(width*4/5,height/2);
	grp2.add(r.createCopy()).fill(#FFCC00).locAt(H.TOP_LEFT);
	grp2.add(r.createCopy()).fill(#FFCC00).locAt(H.BOTTOM_RIGHT);

	/*
	   Setting rotatesChildren to true will
	   make the children of the drawable rotate
	   but not the drawable itself.
	  
	   Unlike stylesChildren() and transformsChildren(),
	   rotatesChildren is *not* set to true in HGroups
	   by default. 
	 */

	d2.rotatesChildren(true);
	grp2.rotatesChildren(true);

	new HRotate(d1,   1);
	new HRotate(d2,   1);
	new HRotate(grp1, 1);
	new HRotate(grp2, 1);
}

void draw() {
	H.drawStage();
}
