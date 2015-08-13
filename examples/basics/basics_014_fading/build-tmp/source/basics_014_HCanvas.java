import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class basics_014_HCanvas extends PApplet {

HColorPool colors;
PGraphics canvas1;
HCanvas   canvas2;
HRect r;

int countDown = 5;
int count = 0;
int ranScale;


public void setup() {

	H.init(this).background(0xff000000);


	colors = new HColorPool(0xffFFFFFF, 0xffF7F7F7, 0xffECECEC, 0xff333333, 0xff0095a8, 0xff00616f, 0xffFF3300, 0xffFF6600);

	canvas1 = createGraphics(320,640);

	canvas2 = new HCanvas().autoClear(false).fade(2);
	H.add(canvas2);

	ranScale = 25+((int)random(5)*25);

	r = new HRect();
	r.noStroke().fill( colors.getColor() ).size( ranScale , ranScale ).loc( (width/2) + (int)random(width/2) , (int)random(height) );
	canvas2.add(r);
}

public void draw() {
	H.drawStage();

	// pick a random RECT size

	ranScale = 25+((int)random(5)*25);

	// move the RECT randomly on the PGraphic

	canvas1.beginDraw();
		canvas1.noStroke();
		canvas1.fill(0xff000000, 5);
		canvas1.rect(0, 0, width, height);
		if (count++ >= countDown) {
			canvas1.noStroke();
			canvas1.fill( colors.getColor() );
			canvas1.rect( (int)random(width/2), (int)random(height), ranScale, ranScale);
			count = 0;
		}
	canvas1.endDraw();
	image(canvas1, 0, 0);

	// move the RECT randomly on the HCanvas

	if (count >= countDown) {
		r.fill( colors.getColor() ).size( ranScale , ranScale ).loc( (width/2) + (int)random(width/2) , (int)random(height) );
	}

	// add type and draw a line seperating the left and right sides

	textSize(18); text("PGraphics fading", 90, 30);
	textSize(18); text("HCanvas fading", 420, 30);
	stroke(0xffFFFFFF); line(320, 0, 320, 640);
}

  public void settings() { 	size(640,640); 	smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "basics_014_HCanvas" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
