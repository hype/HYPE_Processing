// As seen here, we need to preload Images and Fonts.
//
// See http://processingjs.org/reference/preload/
// and http://processingjs.org/reference/font/
// for more information.

/* @pjs preload=" bg.jpg, sintra.jpg "; */

void setup() {
	size(640,640);
	H.init(this).background(#000000).backgroundImg("bg.jpg");
	smooth();

	HImage img0 = (HImage) H.add(new HImage("sintra.jpg")).size(320);
	HImage img1 = (HImage) H.add(img0.createCopy()).x(320);
	HImage img2 = (HImage) H.add(img0.createCopy()).y(320);

	HImage img3 = (HImage) H.add(img0.createCopy()).size(160).loc(320,320);
	HImage img4 = (HImage) H.add(img3.createCopy()).loc(480,320);
	HImage img5 = (HImage) H.add(img3.createCopy()).loc(320,480);

	/*
	* You can set an HImage's tint via fill().
	* 
	* There's also the HImage-specific method,
	* tint() which is aliased to fill(). And like
	* fill, you could use the following parameters:
	*
	* - tint(color)
	* - tint(r,g,b)
	* - tint(color,alpha)
	* - tint(r,g,b,a)
	*/

	img0.tint(0,255,255); // Top Left, Cyan, using tint()

	img1.fill(255,0,255); // Top Right, Magenta, using fill()

	img2.fill(#FFFF00); // Bottom Left, Yellow

	img3.fill(#00FFFF,200); // Bottom Right, Green + Alpha
	img4.fill(#00FFFF,150); // Bottom Right, Green + Alpha
	img5.fill(#00FFFF,100); // Bottom Right, Green + Alpha

	HText txt0 = (HText) H.add(new HText("Cyan Tint")).anchorAt(H.CENTER_X)
		.fill(#FFFFFF).loc(160,10);
	HText txt1 = (HText) H.add(txt0.createCopy().text("Magenta Tint"))
		.move(320,0);
	HText txt2 = (HText) H.add(txt0.createCopy().text("Yellow Tint"))
		.move(0,320);
	HText txt3 = (HText) H.add(txt0.createCopy().text("Green + Alpha Tint"))
		.move(320,320);

	H.drawStage();
	noLoop();
}

void draw() {}

