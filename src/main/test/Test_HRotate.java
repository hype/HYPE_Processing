/**
 * Test Sketch
 *
 * To run from IntelliJ:
 *  - Attach `gluten-rt.jar` and `jog-all.jar` to module libraries
 *  - Create new Run Configuration (Java Application)
 */

import hype.H;
import hype.HBox;
import hype.HGroup;
import hype.extended.behavior.HRotate;
import processing.core.PApplet;

public class Test_HRotate extends PApplet {

	HGroup allBoxes;
	HBox   boxX, boxY, boxZ;

	public void settings() {
		size(640, 640, P3D);
	}

	public void setup() {

		H.init(this).background(0xFF000000).use3D(true);

		H.add( allBoxes = new HGroup() ).anchorAt(H.CENTER); // this would set anchor to width/2 + height/2

		allBoxes.add( boxX = new HBox() ).size(75).noStroke().fill(0xFFFF3300).loc((width/2) - 175, height/2);
		allBoxes.add( boxY = new HBox() ).size(75).noStroke().fill(0xFFFF3300).loc(width/2, height/2);
		allBoxes.add( boxZ = new HBox() ).size(75).noStroke().fill(0xFFFF3300).loc((width/2) + 175, height/2);

		new HRotate().target(allBoxes).speedX(0).speedY(2).speedZ(0);
	}

	public void draw() {
		lights();
		H.drawStage();
	}

	public static void main(String[] args) {
		String[] appletArgs = new String[]{"--window-color=#666666", "--stop-color=#cccccc", "Test_HRotate"};
		if (args != null) {
			PApplet.main(concat(appletArgs, args));
		} else {
			PApplet.main(appletArgs);
		}
	}

}