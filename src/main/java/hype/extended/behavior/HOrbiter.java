/*
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
　
import hype.HBehavior;
import hype.HDrawable;
　
import processing.core.PApplet;
import static processing.core.PApplet.cos;
import static processing.core.PApplet.radians;
import static processing.core.PApplet.sin;
　
public class HOrbiter extends HBehavior {
	private HDrawable target;
	private float startX, startY;
	private float targetX = 0;
	private float targetY = 0;
	private float radius;
	private float speed;
	private boolean rotateTarget = false;
	private float targetRotation = 0;
	private float currentAngle = 0;
	private HOrbiter orbit = null;
	public HOrbiter() {
		startX = startY = 0;
		radius = 100;
		speed = 1;
		register();
	}
	public HOrbiter(float x, float y) {
		startX = x;
		startY = y;
		radius = 100;
		speed = 1;
		register();
	}
	public HOrbiter parent(HOrbiter h) {
		orbit = h;
		return this;
	}
	public HOrbiter parent() {
		return orbit;
	}
　
	public HOrbiter target(HDrawable d) {
		target = d;
		return this;
	}
	public HDrawable target() {
		return target;
	}
	public HOrbiter startX(float f) {
		startX = f;
		return this;
	}
	public float startX() {
		return startX;
	}
	public HOrbiter startY(float f) {
		startY = f;
		return this;
	}
	public float startY() {
		return startY;
	}
	public HOrbiter startAngle(float f) {
		return currentAngle(f);
	}
	public HOrbiter currentAngle(float f) {
		currentAngle = f;
		targetRotation = f;
		return this;
	}
	public float currentAngle() {
		return currentAngle;
	}
	public HOrbiter speed(float f) {
		speed = f;
		return this;
	}
	public float speed() {
		return speed;
	}
	public HOrbiter radius(float f) {
		radius = f;
		return this;
	}
	public float radius() {
		return radius;
	}	
	public HOrbiter rotateTarget(boolean b) {
		rotateTarget = b;
		return this;
	}
	public boolean rotateTarget() {
		return rotateTarget;
	}
	public float x() {
		return targetX;
	}
	public float y() {
		return targetY;
	}
	public void run() {
		if (orbit != null) {
			orbit.run();
			startX = orbit.x();
			startY = orbit.y();
		}
		targetX = cos(radians(currentAngle)) * radius + startX;
		targetY = sin(radians(currentAngle)) * radius + startY;
		currentAngle += speed;
	}
	public void runBehavior(PApplet app) {
		if(target==null) return;
		run();
		target.x(targetX);
		target.y(targetY);
		if (rotateTarget == true) {
			target.rotationZ(targetRotation);
			targetRotation = currentAngle;
		}
	}
	public HOrbiter register() {
		return (HOrbiter) super.register();
	}
	public HOrbiter unregister() {
		return (HOrbiter) super.unregister();
	}
}
