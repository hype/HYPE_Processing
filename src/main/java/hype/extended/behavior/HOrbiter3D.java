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

	private HDrawable target;

	private float radius, ySpeed, zSpeed;
	private float yAngle = 0;
	private float zAngle = 0;

	private float startX, startY, startZ;
	private float targetX, targetY, targetZ;
	private float s, t;

	private HOrbiter3D orbit = null;

	public HOrbiter3D() {
		startX = 0;
		startY = 0;
		startZ = 0;
		radius = 250;
		ySpeed = 0;
		zSpeed = 1;
		register();
	}

	public HOrbiter3D(float x, float y, float z) {
		startX = x;
		startY = y;
		startZ = z;
		radius = 250;
		ySpeed = 0;
		zSpeed = 1;
		register();
	}

	public HOrbiter3D target(HDrawable d) {
		target = d;
		return this;
	}
	
	public HDrawable target() {
		return target;
	}

	public float x() {
		return targetX;
	}

	public float y() {
		return targetY;
	}

	public float z() {
		return targetZ;
	}

	//set and get parent HOrbiter3D
	public HOrbiter3D parent(HOrbiter3D h) {
		orbit = h;
		return this;
	}

	public HOrbiter3D parent() {
		return orbit;
	}


	//set and get start x, y and z
	public HOrbiter3D startX(float f) {
		startX = f;
		return this;
	}

	public HOrbiter3D startY(float f) {
		startY = f;
		return this;
	}

	public HOrbiter3D startZ(float f) {
		startZ = f;
		return this;
	}	
	
	public float startX() {
		return startX;
	}
	public float startY() {
		return startY;
	}
	public float startZ() {
		return startZ;
	}

	//set and get speed for Y and Z angles
	public HOrbiter3D ySpeed(float f) {
		ySpeed = f;
		return this;
	}

	public HOrbiter3D zSpeed(float f) {
		zSpeed = f;
		return this;
	}
	
	public float ySpeed() {
		return ySpeed;
	}
	public float zSpeed() {
		return zSpeed;
	}

	//set and get start angles for Y and Z
	public HOrbiter3D yAngle(float f) {
		yAngle = f;
		return this;
	}

	public HOrbiter3D zAngle(float f) {
		zAngle = f;
		return this;
	}
	
	public float yAngle() {
		return yAngle;
	}
	public float zAngle() {
		return zAngle;
	}

	//set and get radius
	public HOrbiter3D radius(float f) {
		radius = f;
		return this;
	}
	
	public float radius() {
		return radius;
	}

	public void _run() {

		if (orbit != null) {
			orbit._run();
			startX = orbit.x();
			startY = orbit.y();
			startZ = orbit.z();
		}

		s = radians(yAngle);
		t = radians(zAngle);

		targetX = radius * cos(s) * sin(t) + startX;
		targetY = radius * sin(s) * sin(t) + startY;
		targetZ = radius * cos(t) + startZ;

		yAngle += ySpeed;
		zAngle += zSpeed;

	}
	
	@Override
	public void runBehavior(PApplet app) {
		if(target ==null) return;

		_run();

		target.x(targetX);
		target.y(targetY);
		target.z(targetZ);

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
