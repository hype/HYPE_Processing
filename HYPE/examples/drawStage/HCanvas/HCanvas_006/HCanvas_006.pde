/*
	Using a simplified scanline shader, this example demonstrates how to apply
	a PShader to an HCanvas object.

	In the two swarms on screen, half of them have scanlines. These are the 
	drawables that are children of the canvas. The scanline shader is directly 
	applied to the HCanvas and does not affect the drawables on the stage.

	When using shaders with HCanvas, be sure to set the HCanvas renderer to P2D or P3D
*/

import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HTimer;
import hype.extended.behavior.HSwarm;

HColorPool    colors;
HCanvas       canvasShader;
HDrawablePool pool1, pool2;
HSwarm        swarm;
HTimer        timer;
PShader       myShader;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#000000);

	myShader = loadShader("scanlines.glsl");
	myShader.set("resolution", 1.0, 1.0 );
	myShader.set("screenres", float(width), float(height) );
	myShader.set("time", millis()/1000.0);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	canvasShader = (HCanvas) H.add(new HCanvas(P3D).autoClear(true).shader(myShader));	

	swarm = new HSwarm().addGoal(H.mouse()).speed(5).turnEase(0.05f).twitch(20);

	pool1 = new HDrawablePool(20);
	pool1.autoAddToStage()
		.add(new HRect().rounding(4))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.size((int)random(50,100)).fill(colors.getColor()).noStroke().loc(width/2,height/2).anchorAt(H.CENTER);
					swarm.addTarget(d);
				}
			}
		)
	;

	pool2 = new HDrawablePool(20);
	pool2.autoParent(canvasShader)
		.add(new HRect().rounding(4))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.size((int)random(50,100)).fill(colors.getColor()).noStroke().loc(width/2,height/2).anchorAt(H.CENTER);
					swarm.addTarget(d);
				}
			}
		)
	;

	timer = new HTimer()
		.numCycles( pool1.numActive() )
		.interval(250)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					pool1.request();
					pool2.request();
				}
			}
		)
	;
}

void draw() {
	H.drawStage();
	myShader.set("time", millis()/1000.0);
}
