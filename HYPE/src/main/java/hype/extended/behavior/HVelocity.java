package hype.extended.behavior;

import hype.HBehavior;
import hype.interfaces.HLocatable;
import hype.interfaces.HConstants;
import hype.HWarnings;
import processing.core.PApplet;

public class HVelocity extends HBehavior {
	private float velocityX, velocityY, accelX, accelY;
	private HLocatable target;

	public HVelocity target(HLocatable t) {
		if(t == null) unregister();
		else register();
		target = t;
		return this;
	}

	public HLocatable target() {
		return target;
	}

	public HVelocity velocity(float velocity, float deg) {
		return velocityRad(velocity, deg*HConstants.D2R);
	}

	public HVelocity velocityRad(float velocity, float rad) {
		velocityX = velocity * (float)Math.cos(rad);
		velocityY = velocity * (float)Math.sin(rad);
		return this;
	}

	public HVelocity velocityX(float dx) {
		velocityX = dx;
		return this;
	}

	public float velocityX() {
		return velocityX;
	}

	public HVelocity velocityY(float dy) {
		velocityY = dy;
		return this;
	}

	public float velocityY() {
		return velocityY;
	}

	public HVelocity launchTo(float goalX, float goalY, int numFrames) {
		if(target == null) {
			HWarnings.warn("Null Target", "HVelocity.launchTo()",
					HWarnings.NULL_TARGET);
		} else {
			float nfsq = numFrames*numFrames;
			velocityX = (goalX - target.x() - accelX *nfsq/2) / numFrames;
			velocityY = (goalY - target.y() - accelY *nfsq/2) / numFrames;
		}
		return this;
	}

	public HVelocity accel(float acceleration, float deg) {
		return accelRad(acceleration, deg*HConstants.D2R);
	}

	public HVelocity accelRad(float acceleration, float rad) {
		accelX = acceleration * (float)Math.cos(rad);
		accelY = acceleration * (float)Math.sin(rad);
		return this;
	}

	public HVelocity accelX(float ddx) {
		accelX = ddx;
		return this;
	}

	public float accelX() {
		return accelX;
	}

	public HVelocity accelY(float ddy) {
		accelY = ddy;
		return this;
	}

	public float accelY() {
		return accelY;
	}

	@Override
	public void runBehavior(PApplet app) {
		target.x(target.x() + velocityX);
		target.y(target.y() + velocityY);
		velocityX += accelX;
		velocityY += accelY;
	}

	@Override
	public HVelocity register() {
		return (HVelocity) super.register();
	}

	@Override
	public HVelocity unregister() {
		return (HVelocity) super.unregister();
	}
}
