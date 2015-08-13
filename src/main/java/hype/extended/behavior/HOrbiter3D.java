/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * HOrbiter3D
 * by Benjamin Fox / twitter.com/tracerstar / github.com/tracerstar
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.extended.behavior;

import hype.HBehavior;
import hype.HDrawable;
import processing.core.PApplet;
import static processing.core.PApplet.cos;
import static processing.core.PApplet.radians;
import static processing.core.PApplet.sin;

public class HOrbiter3D extends HBehavior {

	private HDrawable _target;

	private float _radius, _ySpeed, _zSpeed;
	private float _yAngle = 0;
	private float _zAngle = 0;

	private float _startX, _startY, _startZ;
	private float _targetX, _targetY, _targetZ;
	private float s, t;

	private HOrbiter3D _orbit = null;

	public HOrbiter3D() {
		_startX = 0;
		_startY = 0;
		_startZ = 0;
		_radius = 250;
		_ySpeed = 0;
		_zSpeed = 1;
		register();
	}

	public HOrbiter3D(float x, float y, float z) {
		_startX = x;
		_startY = y;
		_startZ = z;
		_radius = 250;
		_ySpeed = 0;
		_zSpeed = 1;
		register();
	}

	public HOrbiter3D target(HDrawable d) {
		_target = d;
		return this;
	}
	
	public HDrawable target() {
		return _target;
	}

	public float x() {
		return _targetX;
	}

	public float y() {
		return _targetY;
	}

	public float z() {
		return _targetZ;
	}

	//set and get parent HOrbiter3D
	public HOrbiter3D parent(HOrbiter3D h) {
		_orbit = h;
		return this;
	}

	public HOrbiter3D parent() {
		return _orbit;
	}


	//set and get start x, y and z
	public HOrbiter3D startX(float f) {
		_startX = f;
		return this;
	}

	public HOrbiter3D startY(float f) {
		_startY = f;
		return this;
	}

	public HOrbiter3D startZ(float f) {
		_startZ = f;
		return this;
	}	
	
	public float startX() {
		return _startX;
	}
	public float startY() {
		return _startY;
	}
	public float startZ() {
		return _startZ;
	}

	//set and get speed for Y and Z angles
	public HOrbiter3D ySpeed(float f) {
		_ySpeed = f;
		return this;
	}

	public HOrbiter3D zSpeed(float f) {
		_zSpeed = f;
		return this;
	}
	
	public float ySpeed() {
		return _ySpeed;
	}
	public float zSpeed() {
		return _zSpeed;
	}

	//set and get start angles for Y and Z
	public HOrbiter3D yAngle(float f) {
		_yAngle = f;
		return this;
	}

	public HOrbiter3D zAngle(float f) {
		_zAngle = f;
		return this;
	}
	
	public float yAngle() {
		return _yAngle;
	}
	public float zAngle() {
		return _zAngle;
	}

	//set and get radius
	public HOrbiter3D radius(float f) {
		_radius = f;
		return this;
	}
	
	public float radius() {
		return _radius;
	}

	public void _run() {

		if (_orbit != null) {
			_orbit._run();
			_startX = _orbit.x();
			_startY = _orbit.y();
			_startZ = _orbit.z();
		}

		s = radians(_yAngle);
		t = radians(_zAngle);

		_targetX = _radius * cos(s) * sin(t) + _startX;
		_targetY = _radius * sin(s) * sin(t) + _startY;
		_targetZ = _radius * cos(t) + _startZ;

		_yAngle += _ySpeed;
		_zAngle += _zSpeed;

	}
	
	@Override
	public void runBehavior(PApplet app) {
		if(_target==null) return;

		_run();

		_target.x(_targetX);
		_target.y(_targetY);
		_target.z(_targetZ);

	}
	
	@Override
	public HOrbiter3D register() {
		return (HOrbiter3D) super.register();
	}
	
	@Override
	public HOrbiter3D unregister() {
		return (HOrbiter3D) super.unregister();
	}
}
