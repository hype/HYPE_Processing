import hype.*;

void setup() {
	size(640,640);
	H.init(this).background(#000000).backgroundImg("bg.jpg");

	HImage img1 = (HImage) H.add(new HImage("sintra.jpg")).size(320);
	HImage img2 = (HImage) H.add(img1.createCopy()).x(320);
	HImage img3 = (HImage) H.add(img1.createCopy()).y(320);

	HImage img4 = (HImage) H.add(img1.createCopy()).size(160).loc(320,320);
	HImage img5 = (HImage) H.add(img4.createCopy()).loc(480,320);
	HImage img6 = (HImage) H.add(img4.createCopy()).loc(320,480);

	/*
	  You can set an HImage's tint via fill().
	  
	  There's also the HImage-specific method,
	  tint() which is aliased to fill(). And like
	  fill, you could use the following parameters:
	 
	  - tint(color)
	  - tint(r,g,b)
	  - tint(color,alpha)
	  - tint(r,g,b,a)
	*/

	img1.tint(0,255,255);    // Top Left, Cyan, using tint()
	img2.fill(255,0,255);    // Top Right, Magenta, using fill()
	img3.fill(#FFFF00);      // Bottom Left, Yellow

	img4.fill(#00FFFF, 200); // Bottom Right, Green + Alpha
	img5.fill(#00FFFF, 150); // Bottom Right, Green + Alpha
	img6.fill(#00FFFF, 100); // Bottom Right, Green + Alpha

	HText txt1 = (HText) H.add(new HText("Cyan Tint")).anchorAt(H.CENTER_X).fill(#FFFFFF).loc(160,10);
	HText txt2 = (HText) H.add(txt1.createCopy().text("Magenta Tint")).move(320,0);
	HText txt3 = (HText) H.add(txt1.createCopy().text("Yellow Tint")).move(0,320);
	HText txt4 = (HText) H.add(txt1.createCopy().text("Green + Alpha Tint")).move(320,320);

	H.drawStage();
	noLoop();
}

void draw() {

}
