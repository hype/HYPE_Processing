/* autogenerated by Processing revision 1293 on 2023-08-03 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import hype.*;
import hype.extended.behavior.HRotate;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class basics_004_anchorRotation extends PApplet {




HRect    s1, s2, s3;
HEllipse s4, s5, s6;

public void setup() {
	/* size commented out by preprocessor */;
	H.init(this).background(0xFF242424);
	
	s1 = new HRect(100);
	s1
		.rounding(5)
		.noStroke()
		.fill(0xFFFF3300)
		.anchorAt(H.CENTER)
		.loc(100,180)
	;
	H.add(s1);
	HRotate r1 = new HRotate(); r1.target(s1).speed(1);

	s2 = new HRect(100);
	s2
		.rounding(5)
		.noStroke()
		.fill(0xFFFF6600)
		.loc(320,180)
	;
	H.add(s2);
	HRotate r2 = new HRotate(); r2.target(s2).speed(1);

	s3 = new HRect(100);
	s3
		.rounding(5)
		.noStroke()
		.fill(0xFFFF9900)
		.anchor(50,25)
		.loc(width - 100,180)
	;
	H.add(s3);
	HRotate r3 = new HRotate(); r3.target(s3).speed(1);

// ************************************************************************************

	s4 = new HEllipse(25);
	s4.noStroke().fill(0xFFCCCCCC).anchor(12.5f,75).loc(100,height-180);
	H.add(s4);
	HRotate r4 = new HRotate(); r4.target(s4).speed(random(-2,-1));

	s5 = new HEllipse(25);
	s5.noStroke().fill(0xFFCCCCCC).anchor(12.5f,75).loc(width/2,height-180);
	H.add(s5);
	HRotate r5 = new HRotate(); r5.target(s5).speed(random(-4,-2));

	s6 = new HEllipse(25);
	s6.noStroke().fill(0xFFCCCCCC).anchor(12.5f,75).loc(width-100,height-180);
	H.add(s6);
	HRotate r6 = new HRotate(); r6.target(s6).speed(random(-8,-4));
}

public void draw() {
	H.drawStage();

	// using ellipse to mark the moved registration points

	strokeWeight(2); stroke(0xFF0095A8); fill(0xFF333333); 

	ellipse(s1.x(), s1.y(), 6, 6);
	ellipse(s2.x(), s2.y(), 6, 6);
	ellipse(s3.x(), s3.y(), 6, 6);

	ellipse(s4.x(), s4.y(), 6, 6);
	ellipse(s5.x(), s5.y(), 6, 6);
	ellipse(s6.x(), s6.y(), 6, 6);
}


  public void settings() { size(640, 640); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "basics_004_anchorRotation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
