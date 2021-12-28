package hype.extended.behavior;

import hype.HBehavior;
import hype.HLinkedHashSet;
import hype.HDrawable;
import processing.core.PApplet;
import processing.core.PVector;
import java.util.ArrayList;
import static processing.core.PApplet.abs;
import static processing.core.PApplet.atan2;

public class HMagneticField extends HBehavior {
	private ArrayList<HPole> poles;
	private HLinkedHashSet<HDrawable> targets;

	public HMagneticField() {
		poles = new ArrayList<HMagneticField.HPole>();
		targets = new HLinkedHashSet<HDrawable>();
	}

	public HMagneticField addMagnet(float nx, float ny, float sx, float sy) {
		addPole(nx, ny, 1);
		addPole(sx, sy, -1);
		return this;
	}

	public HMagneticField addPole(float x, float y, float polarity) {
		HPole p = new HPole(x, y, polarity);
		poles.add(p);
		return this;
	}

	public HPole pole(int index) {
		return poles.get(index);
	}

	public HMagneticField removePole(int index) {
		poles.remove(index);
		return this;
	}

	public HMagneticField addTarget(HDrawable d) {
		if(targets.size() <= 0) register();
		targets.add(d);
		return this;
	}

	public HMagneticField removeTarget(HDrawable d) {
		targets.remove(d);
		if(targets.size() <= 0) unregister();
		return this;
	}

	public float getRotation(float x, float y) {

		int poleCount = poles.size();

		PVector v1 = new PVector(0, 0);
		PVector v2 = new PVector(x, y);

		PVector distance = new PVector(0, 0);
		PVector force = new PVector(0, 0);

		float d = 0;

		for(int i=0; i<poleCount; i++) {
			HPole p = poles.get(i);

			v1.x = p.x;
			v1.y = p.y;

			if (p.polarity < 0) {
				distance = PVector.sub(v1, v2);
			} else {
				distance = PVector.sub(v2, v1);
			}

			d = distance.mag() / 5;

			distance.normalize();
			distance.mult(abs(p.polarity));
			distance.div(d);

			force.add(distance);

		}
    	return atan2(force.y, force.x);
	}

	@Override
	public void runBehavior(PApplet app) {
		for(HDrawable d : targets) d.rotationRad( getRotation(d.x(), d.y()) );
	}

	@Override
	public HMagneticField register() {
		return (HMagneticField) super.register();
	}

	@Override
	public HMagneticField unregister() {
		return (HMagneticField) super.unregister();
	}

	public static class HPole {
		public float x, y, polarity;

		public HPole(float x, float y, float polarity) {
			this.x = x;
			this.y = y;
			this.polarity = polarity;
		}

	}
}
