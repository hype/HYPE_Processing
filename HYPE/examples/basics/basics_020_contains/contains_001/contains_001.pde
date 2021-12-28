import hype.*;

HGroup rects;
HRect  rBorder, r1, r2, r3, r4, r5, r6, r7, r8;
HShape arrow;

void setup(){
	size(640,640);
	H.init(this).background(#242424);

	rects = H.add(new HGroup());

	// first row of HRect's

	r1 = new HRect(119,219).rounding(8);
	r1.strokeWeight(2).stroke(#181818).fill(#333333).loc(55,65);
	rects.add(r1);

	r2 = new HRect(119,219).rounding(8);
	r2.strokeWeight(2).stroke(#181818).fill(#333333).loc(192,65);
	rects.add(r2);

	r3 = new HRect(119,219).rounding(8);
	r3.strokeWeight(2).stroke(#181818).fill(#333333).loc(329,65);
	rects.add(r3);

	r4 = new HRect(119,219).rounding(8);
	r4.strokeWeight(2).stroke(#181818).fill(#333333).loc(466,65);
	rects.add(r4);

	// second row of HRect's

	r5 = new HRect(119,119).rounding(8);
	r5.strokeWeight(2).stroke(#181818).fill(#333333).loc(r1.x(),349);
	rects.add(r5);

	r6 = new HRect(119,119).rounding(8);
	r6.strokeWeight(2).stroke(#181818).fill(#333333).loc(r2.x(),349);
	rects.add(r6);

	r7 = new HRect(119,119).rounding(8);
	r7.strokeWeight(2).stroke(#181818).fill(#333333).loc(r3.x(),349);
	rects.add(r7);

	r8 = new HRect(119,119).rounding(8);
	r8.strokeWeight(2).stroke(#181818).fill(#333333).loc(r4.x(),349);
	rects.add(r8);

	// border HRect and HShape arrow SVG

	rBorder = new HRect(r1.width() + 8,r1.height() + 8).rounding(10);
	rBorder.strokeWeight(2).stroke(#FF6600).noFill().loc(r1.x() - 4,r1.y() - 4);
	H.add(rBorder);

	arrow = new HShape("arrow.svg").enableStyle(false);
	arrow
		.noStroke()
		.fill(#FF3300)
		.anchorAt(H.CENTER)
		.rotation(90)
		.scale(2)
		.loc( r1.x() + (r1.width() / 2), r1.y() - 30 )
	;
	H.add(arrow);
}

void draw(){
	for (HDrawable d : rects){
		if(d.contains(mouseX,mouseY)) {
			PVector pt = d.size();
			rBorder.size( pt.x + 8, pt.y + 8 ).loc( d.x()-4, d.y()-4 );
			arrow.loc( d.x() + (d.width() / 2), d.y()-30 );
		}
	}

	H.drawStage();

	fill(#666666); textSize(18); text("MouseMove to update hit areas", r1.x(), height - 55);
}
