/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HVelocity extends HBehavior {
	private float _velocityX, _velocityY, _accelX, _accelY;
	private HLocatable _target;
	public HVelocity target(HLocatable t) {
		if(t == null) unregister();
		else register();
		_target = t;
		return this;
	}
	public HLocatable target() {
		return _target;
	}
	public HVelocity velocity(float velocity, float deg) {
		return velocityRad(velocity, deg*HConstants.D2R);
	}
	public HVelocity velocityRad(float velocity, float rad) {
		_velocityX = velocity * (float)Math.cos(rad);
		_velocityY = velocity * (float)Math.sin(rad);
		return this;
	}
	public HVelocity velocityX(float dx) {
		_velocityX = dx;
		return this;
	}
	public float velocityX() {
		return _velocityX;
	}
	public HVelocity velocityY(float dy) {
		_velocityY = dy;
		return this;
	}
	public float velocityY() {
		return _velocityY;
	}
	public HVelocity launchTo(float goalX, float goalY, int numFrames) {
		if(_target == null) {
			HWarnings.warn("Null Target", "HVelocity.launchTo()",
					HWarnings.NULL_TARGET);
		} else {
			float nfsq = numFrames*numFrames;
			_velocityX = (goalX - _target.x() - _accelX*nfsq/2) / numFrames;
			_velocityY = (goalY - _target.y() - _accelY*nfsq/2) / numFrames;
		}
		return this;
	}
	public HVelocity accel(float acceleration, float deg) {
		return accelRad(acceleration, deg*HConstants.D2R);
	}
	public HVelocity accelRad(float acceleration, float rad) {
		_accelX = acceleration * (float)Math.cos(rad);
		_accelY = acceleration * (float)Math.sin(rad);
		return this;
	}
	public HVelocity accelX(float ddx) {
		_accelX = ddx;
		return this;
	}
	public float accelX() {
		return _accelX;
	}
	public HVelocity accelY(float ddy) {
		_accelY = ddy;
		return this;
	}
	public float accelY() {
		return _accelY;
	}
	public void runBehavior(PApplet app) {
		_target.x(_target.x() + _velocityX);
		_target.y(_target.y() + _velocityY);
		_velocityX += _accelX;
		_velocityY += _accelY;
	}
	public HVelocity register() {
		return (HVelocity) super.register();
	}
	public HVelocity unregister() {
		return (HVelocity) super.unregister();
	}
}
