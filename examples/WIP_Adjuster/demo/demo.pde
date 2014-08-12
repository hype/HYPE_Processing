HRect s1, selectedRect;

void setup(){
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	s1 = new HRect(100);
	s1.rounding(10).noStroke().fill(#ECECEC).loc(width/2,height/2).anchorAt(H.CENTER).rotation(45);
	PVector s1Size = s1.boundingSize();
	H.add(s1);

	selectedRect = new HRect(100);
	selectedRect
		.strokeWeight(1)
		.stroke(#FF0033)
		.noFill()
		.size( s1Size.x, s1Size.y )
		.anchorAt(H.CENTER)
		.visibility(false)
		.loc( s1.x(), s1.y() )
	;
	H.add(selectedRect);
}

void draw(){
	H.drawStage();
}

void mousePressed() { 
 	if (mouseX > s1.x()-s1.width() && mouseX < s1.x()+s1.width() && mouseY > s1.y()-s1.height() && mouseY < s1.y()+s1.height()) {
 		selectedRect.visibility(true);
	} else {
 		selectedRect.visibility(false);
	}
}

void mouseReleased() {
	// not being used
}

void mouseDragged() {
	s1.x(mouseX);
	s1.y(mouseY);
	selectedRect.x(mouseX);
	selectedRect.y(mouseY);
}

void keyReleased() {
	if (key == DELETE || key == BACKSPACE) {
		H.remove(s1);
		H.remove(selectedRect);
	}
}

