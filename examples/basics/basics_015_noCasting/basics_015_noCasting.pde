import hype.*;

/* 
   This testfile demonstrates the recently added
   feature that lets you call H.add() and remove()
   to assign variables without needing to cast them.
  
   Be noted that the problems presented in this test
   file were only relevant in *Java Mode*, due to the
   language's strict typing.
  
   --------------
   Instead of:
  
       HRect r = (HRect) H.add(new HRect());
   
   You can now do this:
   
       HRect r = H.add(new HRect());
   
   Technical:
   ----------
   I simply made multiple add() and remove() methods
   for each drawable class in class H.
   
   Even though I have more than one of each of the
   aforementioned methods, this wouldn't cause an
   issue with JS Mode. All those functions would have
   just merged into the original H.add() and H.remove()
   functions, which would work just fine due to its
   weak typing.
 */

void setup() {
	size(640,640);
	H.init(this).background(#242424);

	H.add( new HEllipse() )
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FFCC00)
		.size(100)
		.anchorAt(H.CENTER)
		.loc(100, height/2)
	;

	H.add( new HRect() )
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF9900)
		.size(100)
		.anchorAt(H.CENTER)
		.loc(250, height/2)
	;

	H.add( new HPath() )
		.star(5, 0.5, 90)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF6600)
		.size(110)
		.anchorAt(H.CENTER)
		.loc(400, height/2)
	;

	H.add( new HPath(POLYGON) )
		.vertex(490,270)
		.vertex(590,370)
		.vertex(490,370)
		.vertex(590,270)
		.strokeWeight(6)
		.stroke(#000000, 100)
		.fill(#FF3300)
	;

	/*
	  Here's the list of classes that you no longer need to
	  cast with H.add() and H.remove() as of build_21030531.0:
	  
	  - HCanvas
	  - HEllipse
	  - HGroup
	  - HImage
	  - HPath
	  - HRect
	  - HShape
	  - HText
	 
	  If you created your own HDrawable class, then you'll still
	  need to do the old casting thing.
	*/

	H.drawStage();
	noLoop();
}

void draw() {

}
