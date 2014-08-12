
void setup(){
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	HPolarLayout layout = new HPolarLayout(1, 0.2, width / 2, height / 2, false, 0.007);

	for (int i = 0; i<300; i++){
		
		HRect d = new HRect(10).rounding(3);
		d.noStroke().fill(#ff3300).anchorAt(H.CENTER);
		layout.applyLayout(d);

		H.add(d);

	}

	H.drawStage();
	noLoop();
}
 
void draw(){ }

