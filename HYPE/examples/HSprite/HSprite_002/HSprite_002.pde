import hype.*;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#FF3300).use3D(true);

	// JPG textures

	H.add( new HSprite().texture("tex1.jpg") ).size(200).anchorAt(H.CENTER).loc((width/2)-210, height/3);
	H.add( new HSprite().texture("tex2.jpg") ).size(200).anchorAt(H.CENTER).loc((width/2), height/3);
	H.add( new HSprite().texture("tex3.jpg") ).size(200).anchorAt(H.CENTER).loc((width/2)+210, height/3);

	// PNG textures / being the ideal texture to map to HSprite / nothing but transparency love

	H.add( new HSprite().texture("tex1.png") ).size(200).anchorAt(H.CENTER).loc((width/2)-210, height/1.5);
	H.add( new HSprite().texture("tex2.png") ).size(200).anchorAt(H.CENTER).loc((width/2), height/1.5);
	H.add( new HSprite().texture("tex3.png") ).size(200).anchorAt(H.CENTER).loc((width/2)+210, height/1.5);
}

void draw() {
	H.drawStage();
}
