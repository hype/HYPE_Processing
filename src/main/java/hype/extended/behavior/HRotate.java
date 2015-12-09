package hype.extended.behavior;

import hype.HBehavior;
import hype.interfaces.HRotatable;
import hype.interfaces.HConstants;
import processing.core.PApplet;

public class HRotate extends HBehavior {
	private HRotatable target;
	private float speedRad;

	public HRotate() {}

	public HRotate(HRotatable newTarget, float dDeg) {
		target(newTarget);
		speedRad = dDeg * HConstants.D2R;
	}

	public HRotate target(HRotatable r) {
		if(r == null) unregister();
		else register();

		target = r;
		return this;
	}

	public HRotatable target() {
		return target;
	}

	public HRotate speed(float dDeg) {
		speedRad = dDeg * HConstants.D2R;
		return this;
	}

	public float speed() {
		return speedRad * HConstants.R2D;
	}

	public HRotate speedRad(float dRad) {
		speedRad = dRad;
		return this;
	}

	public float speedRad() {
		return speedRad;
	}

	@Override
	public void runBehavior(PApplet app) {
		float rot = target.rotationRad() + speedRad;
		target.rotationRad(rot);
	}

	@Override
	public HRotate register() {
		return (HRotate) super.register();
	}

	@Override
	public HRotate unregister() {
		return (HRotate) super.unregister();
	}
}
