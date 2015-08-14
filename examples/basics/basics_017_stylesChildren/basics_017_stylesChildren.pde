import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	HDrawable p = new HPath().vertexUV(0,0).vertexUV(0,1).vertexUV(1,0).vertexUV(1,1).size(50);

	HDrawable d1 = H.add(new HEllipse(25)).anchorAt(H.CENTER).loc(width/2-190,height/2);
	d1.add(p.createCopy()).anchorAt(H.BOTTOM_RIGHT).locAt(H.TOP_LEFT);
	d1.add(p.createCopy()).anchorAt(H.BOTTOM_LEFT).locAt(H.TOP_RIGHT);
	d1.add(p.createCopy()).anchorAt(H.TOP_LEFT).locAt(H.BOTTOM_RIGHT);
	d1.add(p.createCopy()).anchorAt(H.TOP_RIGHT).locAt(H.BOTTOM_LEFT);

	HDrawable d2 = H.add(new HEllipse(25)).anchorAt(H.CENTER).locAt(H.CENTER);
	d2.add(p.createCopy()).anchorAt(H.BOTTOM_RIGHT).locAt(H.TOP_LEFT);
	d2.add(p.createCopy()).anchorAt(H.BOTTOM_LEFT).locAt(H.TOP_RIGHT);
	d2.add(p.createCopy()).anchorAt(H.TOP_LEFT).locAt(H.BOTTOM_RIGHT);
	d2.add(p.createCopy()).anchorAt(H.TOP_RIGHT).locAt(H.BOTTOM_LEFT);

	HDrawable grp = H.add(new HGroup()).size(50).anchorAt(H.CENTER).loc(width/2+190,height/2);
	grp.add(p.createCopy()).anchorAt(H.BOTTOM_RIGHT).locAt(H.TOP_LEFT);
	grp.add(p.createCopy()).anchorAt(H.BOTTOM_LEFT).locAt(H.TOP_RIGHT);
	grp.add(p.createCopy()).anchorAt(H.TOP_LEFT).locAt(H.BOTTOM_RIGHT);
	grp.add(p.createCopy()).anchorAt(H.TOP_RIGHT).locAt(H.BOTTOM_LEFT);

	/*
	   We're setting d1 to style its children
	   via stylesChildren(true)
	   
	   d2 will remain to its default behavior.
	  
	   Once again, HGroups by default will style
	   its children by default.
	  
	   To remove this behavior,
	   call stylesChildren(false)
	 */

	d1.stylesChildren(true);

	/*
	   setting stylesChildren to true would affect
	   the following fields of the children:
	  
	   - fill color
	   - stroke color
	   - stroke weight
	   - stroke join
	   - stroke cap
	 */

	// d1 will pass its styling to its children

	d1
		.strokeWeight(4)
		.strokeJoin(BEVEL)
		.strokeCap(ROUND)
		.stroke(#FF3300)
		.fill(#333333)
	;

	// d2 will only style itself

	d2
		.strokeWeight(4)
		.strokeJoin(BEVEL)
		.strokeCap(ROUND)
		.stroke(#FF3300)
		.fill(#333333)
	;


	// grp will also pass the styling to its children,
	// because that's HGroup's default behavior

	grp
		.strokeWeight(4)
		.strokeJoin(BEVEL)
		.strokeCap(ROUND)
		.stroke(#FF3300)
		.fill(#333333)
	;


	H.add(new HText("stylesChildren(true)",  14)).fill(#999999).anchorAt(H.CENTER_TOP).loc(width/2-190,height*3/4);
	H.add(new HText("stylesChildren(false)", 14)).fill(#999999).anchorAt(H.CENTER_TOP).loc(width/2,height*3/4);
	H.add(new HText("HGroup defaults",       14)).fill(#999999).anchorAt(H.CENTER_TOP).loc(width/2+190,height*3/4);

	H.drawStage();
	noLoop();
}
