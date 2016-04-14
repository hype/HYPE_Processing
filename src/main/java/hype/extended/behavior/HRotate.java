/**
 * HRotate
 *
 * Updated by @DonoG on 4/2/16 to enable X,Y and Z rotations
 */

package hype.extended.behavior;

import hype.HBehavior;
import hype.interfaces.HRotatable;
import hype.interfaces.HConstants;
import processing.core.PApplet;

public class HRotate extends HBehavior {
	private HRotatable target;
	private float speedXRad;
	private float speedYRad;
	private float speedZRad;

	public HRotate() {}

	/** @deprecated */
	public HRotate(HRotatable newTarget, float dDeg) {
		target(newTarget);
		speedZRad = dDeg * HConstants.D2R;
	}

	//new constructor to allow x, y and z rotation to be passed
	public HRotate(HRotatable newTarget, float xDeg, float yDeg, float zDeg) {
		target(newTarget);
		speedXRad = xDeg * HConstants.D2R;
		speedYRad = yDeg * HConstants.D2R;
		speedZRad = zDeg * HConstants.D2R;
	}

	public HRotate target(HRotatable r) {
		if (r == null) unregister();
		else register();
		target = r;
		return this;
	}

	public HRotatable target() {
		return target;
	}

	/** @deprecated */
	public HRotate speed(float dDeg) {
		speedZRad = dDeg * HConstants.D2R;
		return this;
	}

	/** @deprecated */
	public float speed() {
		return speedZRad * HConstants.R2D;
	}

	/** @deprecated */
	public HRotate speedRad(float dRad) {
		speedZRad = dRad;
		return this;
	}

	/** @deprecated */
	public float speedRad() {
		return speedZRad;
	}

	public HRotate speedX(float dDeg) {
		speedXRad = dDeg * HConstants.D2R;
		return this;
	}

	public float speedX() {
		return speedXRad * HConstants.R2D;
	}

	public HRotate speedXRad(float dRad) {
		speedXRad = dRad;
		return this;
	}

	public float speedXRad() {
		return speedXRad;
	}

	public HRotate speedY(float dDeg) {
		speedYRad = dDeg * HConstants.D2R;
		return this;
	}

	public float speedY() {
		return speedYRad * HConstants.R2D;
	}

	public HRotate speedYRad(float dRad) {
		speedYRad = dRad;
		return this;
	}

	public float speedYRad() {
		return speedYRad;
	}

	public HRotate speedZ(float dDeg) {
		speedZRad = dDeg * HConstants.D2R;
		return this;
	}

	public float speedZ() {
		return speedZRad * HConstants.R2D;
	}

	public HRotate speedZRad(float dRad) {
		speedZRad = dRad;
		return this;
	}

	public float speedZRad() {
		return speedZRad;
	}

	@Override
	public void runBehavior(PApplet app) {
		float rotX = target.rotationXRad() + speedXRad;
		float rotY = target.rotationYRad() + speedYRad;
		float rotZ = target.rotationZRad() + speedZRad;
		target.rotationXRad(rotX);
		target.rotationYRad(rotY);
		target.rotationRad(rotZ);
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
