/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * HOrbiter
 * by Benjamin Fox / twitter.com/tracerstar / github.com/tracerstar
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.extended.behavior;

import hype.core.behavior.HBehavior;
import hype.core.drawable.HDrawable;
import processing.core.PApplet;

public class HOrbiter extends HBehavior {

	private HDrawable _target;

	private float _startX, _startY;
	private float _targetX = 0;
	private float _targetY = 0;
	private float _radius;
	private float _speed;
	
	private boolean _rotateTarget = false;
	private float _targetRotation = 0;

	private float _currentAngle = 0;

	private HOrbiter _orbit = null;

	public HOrbiter() {
		_startX = _startY = 0;
		_radius = 100;
		_speed = 1;
		register();
	}

	public HOrbiter(float _x, float _y) {
		_startX = _x;
		_startY = _y;
		_radius = 100;
		_speed = 1;
		register();
	}

	public HOrbiter parent(HOrbiter h) {
		_orbit = h;
		return this;
	}

	public HOrbiter parent() {
		return _orbit;
	}

	public HOrbiter target(HDrawable d) {
		_target = d;
		return this;
	}
	
	public HDrawable target() {
		return _target;
	}

	public HOrbiter startX(float f) {
		_startX = f;
		return this;
	}

	public float startX() {
		return _startX;
	}

	public HOrbiter startY(float f) {
		_startY = f;
		return this;
	}

	public float startY() {
		return _startY;
	}

	public HOrbiter startAngle(float f) {
		return currentAngle(f);
	}

	public HOrbiter currentAngle(float f) {
		_currentAngle = f;
		_targetRotation = f;
		return this;
	}

	public float currentAngle() {
		return _currentAngle;
	}
	
	public HOrbiter speed(float f) {
		_speed = f;
		return this;
	}
	
	public float speed() {
		return _speed;
	}
	
	public HOrbiter radius(float f) {
		_radius = f;
		return this;
	}
	
	public float radius() {
		return _radius;
	}	

	public HOrbiter rotateTarget(boolean b) {
		_rotateTarget = b;
		return this;
	}

	public boolean rotateTarget() {
		return _rotateTarget;
	}

	public float x() {
		return _targetX;
	}

	public float y() {
		return _targetY;
	}


	public void _run() {

		if (_orbit != null) {
			_orbit._run();
			_startX = _orbit.x();
			_startY = _orbit.y();
		}

		_targetX = cos(radians(_currentAngle)) * _radius + _startX;
		_targetY = sin(radians(_currentAngle)) * _radius + _startY;

		_currentAngle += _speed;

	}
	
	@Override
	public void runBehavior(PApplet app) {
		if(_target==null) return;

		_run();

		_target.x(_targetX);
		_target.y(_targetY);

		if (_rotateTarget == true) {
			_target.rotationZ(_targetRotation);
			_targetRotation = _currentAngle;
		}
	}
	
	@Override
	public HOrbiter register() {
		return (HOrbiter) super.register();
	}
	
	@Override
	public HOrbiter unregister() {
		return (HOrbiter) super.unregister();
	}
}
