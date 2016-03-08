/**
 * HGroup
 *
 * Updated by @DonoG on 26/1/16 to enable X,Y and Z rotations
 */

package hype;
import processing.core.PGraphics;

public class HGroup extends HDrawable {

	public HGroup() {
		transformsChildren(true).stylesChildren(true);
	}

	@Override
	public HGroup createCopy() {
		HGroup copy = new HGroup();
		copy.copyPropertiesFrom(this);
		return copy;
	}

	@Override
	public void paintAll(PGraphics g, boolean usesZ, float alphaPc) {
		if (alphaPc<=0) return;

		// Perform a trimmed down version of super.paintAll()
		g.pushMatrix();

		if (usesZ) {
			g.translate(x, y, z);
			g.rotateX(rotationXRad);
			g.rotateY(rotationYRad);
			g.rotateZ(rotationZRad);
		} else {
			g.translate(x, y);
			g.rotate(rotationZRad);
		}

		alphaPc *= alphaPc;
		HDrawable child = firstChild;
		while (child != null) {
			child.paintAll(g, usesZ, alphaPc);
			child = child.next();
		}
		g.popMatrix();
	}

	@Override
	public void draw(PGraphics g, boolean b, float x, float y, float f) {}
}
