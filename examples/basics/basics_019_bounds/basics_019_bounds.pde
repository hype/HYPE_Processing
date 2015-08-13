HRect boundingBox, r;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	H.add(r = new HRect(100).rounding(10))
		.noStroke()
		.fill(#0095a8)
		.anchorAt(H.CENTER)
		.locAt(H.CENTER)
	;

	H.add(boundingBox = new HRect().rounding(10))
		.strokeWeight(2)
		.stroke(#FF3300)
		.noFill()
	;

	new HRotate().target(r).speed(1);
	new HFollow().target(r);
}

void draw() {
	// `r.bounds()` will set the x & y fields of `loc` and `size`
	PVector loc = new PVector(), size = new PVector();
	r.bounds(loc,size);
	boundingBox.loc(loc.x,loc.y).size(size.x,size.y);

	H.drawStage();
}

