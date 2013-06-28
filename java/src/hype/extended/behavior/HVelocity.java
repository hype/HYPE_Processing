/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.extended.behavior;

import hype.core.behavior.HBehavior;
import hype.core.interfaces.HLocatable;
import hype.core.util.HConstants;
import hype.core.util.HWarnings;
import processing.core.PApplet;

public class HVelocity extends HBehavior {
	private PVector _velocity;
	private PVector _accel;
	private float _limit;
	private boolean _hasLimit;
	private HLocatable _target;

	public HVelocity() {
		_velocity = new PVector();
		_accel = new PVector();
		_limit = 0.0f;
		_hasLimit = false;
	}
	
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
		float velX = velocity * (float)Math.cos(rad);
		float velY = velocity * (float)Math.sin(rad);
		_velocity = new PVector(velX, velY);
		return this;
	}
	
	public HVelocity velocityX(float dx) {
		_velocity.x = dx;
		return this;
	}
	
	public float velocityX() {
		return _velocity.x;
	}
	
	public HVelocity velocityY(float dy) {
		_velocity.y = dy;
		return this;
	}
	
	public float velocityY() {
		return _velocity.y;
	}
	
	public HVelocity launchTo(float goalX, float goalY, int numFrames) {
		if(_target == null) {
			HWarnings.warn("Null Target", "HVelocity.launchTo()",
					HWarnings.NULL_TARGET);
		} else {
			float nfsq = numFrames*numFrames;
			float velX = (goalX - _target.x() - _accel.x*nfsq/2) / numFrames;
			float velY = (goalY - _target.y() - _accel.y*nfsq/2) / numFrames;
			_velocity = new PVector(velX, velY);
		}
		return this;
	}
	
	public HVelocity accel(float acceleration, float deg) {
		return accelRad(acceleration, deg*HConstants.D2R);
	}

	public HVelocity accelRad(float acceleration, float rad) {
		float accelX = acceleration * (float)Math.cos(rad);
		float accelY = acceleration * (float)Math.sin(rad);
		_accel = new PVector(accelX, accelY);
		return this;
	}
	
	public HVelocity accelX(float ddx) {
		_accel.x = ddx;
		return this;
	}
	
	public float accelX() {
		return _accel.x;
	}
	
	public HVelocity accelY(float ddy) {
		_accel.y = ddy;
		return this;
	}
	
	public float accelY() {
		return _accel.y;
	}

	public HVelocity limit(float limit) {
		_limit = limit;
		_hasLimit = true;
		return this;
	}

	public float limit() {
		return _limit;
	}

	public HVelocity hasLimit(boolean hasLimit) {
		_hasLimit = hasLimit;
		return this;
	}

	public boolean hasLimit() {
		return _hasLimit;
	}
	
	@Override
	public void runBehavior(PApplet app) {
		PVector newLoc = PVector.add( new PVector( _target.x(), _target.y() ) , _velocity );

		_target.x(newLoc.x);
		_target.y(newLoc.y);
		
		_velocity.add(_accel);

		if (_hasLimit) {
			_velocity.limit(_limit);
		}
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
