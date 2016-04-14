/**
 * Test Sketch
 *
 * To run from IntelliJ:
 *  - Attach `gluten-rt.jar` and `jog-all.jar` to module libraries
 *  - Create new Run Configuration (Java Application)
 */

import hype.*;
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

		HDrawable allBoxes = H.add(new HGroup()).anchorAt(H.BOTTOM_LEFT).size(300).locAt(H.CENTER);

		allBoxes.add( boxX = new HBox() ).size(75).noStroke().fill(0xFFFF3300).locAt(H.LEFT);
		allBoxes.add( boxY = new HBox() ).size(75).noStroke().fill(0xFFFF3300).locAt(H.CENTER);
		allBoxes.add( boxZ = new HBox() ).size(75).noStroke().fill(0xFFFF3300).locAt(H.RIGHT);

		new HRotate().target(allBoxes).speedX(0).speedY(4).speedZ(0);
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