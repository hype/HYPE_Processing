import hype.*;
import hype.extended.behavior.HRotate;
import hype.extended.behavior.HFollow;

HGroup rects;
HRect  rBorder, progressBorder, progressBar, r1, r2, r3, r4, r5, r6, r7, r8;
HShape arrow;

float  progressMax;

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
	rBorder.strokeWeight(2).stroke(#FF6600).noFill().loc(r1.x() - 4,r1.y() - 4).visibility(true);
	H.add(rBorder);

	arrow = new HShape("arrow.svg").enableStyle(false);
	arrow
		.noStroke()
		.fill(#FF3300)
		.anchorAt(H.CENTER)
		.rotation(90)
		.scale(2)
		.loc( r1.x() + (r1.width() / 2), r1.y() - 30 )
		.visibility(true)
	;
	H.add(arrow);

	// mouseFollow assets

	HShape arc1 = new HShape("arc2.svg"); arc1.scale(1).loc(-100,-100);
	new HRotate(arc1, 2); new HFollow().target(arc1);
	H.add(arc1);

	HShape arc2 = new HShape("arc3.svg"); arc2.scale(0.65).loc(-100,-100);
	new HRotate(arc2, -3); new HFollow().target(arc2);
	H.add(arc2);

	HShape arc3 = new HShape("arc1.svg"); arc3.scale(0.45).loc(-100,-100);
	new HRotate(arc3, 4); new HFollow().target(arc3);
	H.add(arc3);

	progressBorder = new HRect(100,24).rounding(5);
	progressBorder.strokeWeight(2).stroke(#0095a8).noFill().anchor(50, -50).visibility(false);
	new HFollow().target(progressBorder);
	H.add(progressBorder);

	progressBar = new HRect(92,16).rounding(3);
	progressMax = progressBar.width();
	progressBar.stroke(#00616f).fill(#00616f).loc(-progressBorder.anchorX() + 4,-progressBorder.anchorY()+4).visibility(false).width(0);
	progressBorder.add(progressBar);

}

void draw(){
	HDrawable hitDrawable = null;

	for (HDrawable d : rects){
		if(d.contains(mouseX,mouseY)) {
			hitDrawable = d;
			progressBorder.visibility(true);
			progressBar.visibility(true);
		}
	}

	if (hitDrawable != null){
		progressAnim(hitDrawable);	
	} else {
		progressBorder.visibility(false);
		progressBar.visibility(false).width(0);
	}

	H.drawStage();

	fill(#666666); textSize(18); text("MouseHover in hit area to activate / kinect use", r1.x(), height - 55);
}

void progressAnim(HDrawable d) {
	if (progressBar.width() >= progressMax ) {
		progressBar.width(progressMax);
		PVector pt = d.size();
		rBorder.size( pt.x + 8, pt.y + 8 ).loc( d.x()-4, d.y()-4 );
		arrow.loc( d.x() + (d.width() / 2), d.y()-30 );
	} else {
		progressBar.width( progressBar.width() + 1 );
	}
}
