package hype.behavior;

import hype.interfaces.HLocatable;
import hype.util.H;
import hype.util.HConstants;
import hype.util.HWarnings;
import processing.core.PApplet;

public class HVelocity extends HBehavior {
	protected boolean _autoRegisters;
	protected float _velocityX, _velocityY, _accelX, _accelY;
	protected HLocatable _target;
	
	public HVelocity() {
		_autoRegisters = true;
	}
	
	public HVelocity(boolean isAutoRegister) {
		_autoRegisters = isAutoRegister;
	}
	
	public HVelocity autoRegisters(boolean b) {
		_autoRegisters = b;
		return this;
	}
	
	public boolean autoRegisters() {
		return _autoRegisters;
	}
	
	public HVelocity target(HLocatable t) {
		if(_autoRegisters) {
			if(t == null) unregister();
			else register();
		}
		_target = t;
		return this;
	}
	
	public HLocatable target() {
		return _target;
	}
	
	public HVelocity velocity(float velocity, float deg) {
		return velocityRad(velocity, deg*HConstants.D2R);
	}
	
	@SuppressWarnings("static-access")
	public HVelocity velocityRad(float velocity, float rad) {
		PApplet app = H.app();
		_velocityX = velocity * app.cos(rad);
		_velocityY = velocity * app.sin(rad);
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

	@SuppressWarnings("static-access")
	public HVelocity accelRad(float acceleration, float rad) {
		PApplet app = H.app();
		_accelX = acceleration * app.cos(rad);
		_accelY = acceleration * app.sin(rad);
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
	
	@Override
	public void runBehavior(PApplet app) {
		_target.x(_target.x() + _velocityX);
		_target.y(_target.y() + _velocityY);
		_velocityX += _accelX;
		_velocityY += _accelY;
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
