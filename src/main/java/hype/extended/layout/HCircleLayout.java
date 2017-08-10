package hype.extended.layout;

import hype.interfaces.HLayout;
import hype.H;
import hype.HDrawable;
import hype.HMath;

import processing.core.PVector;
 
import static processing.core.PApplet.cos;
import static processing.core.PApplet.sin;
import static processing.core.PApplet.radians;
import static processing.core.PApplet.abs;
import static processing.core.PApplet.map;
 
public class HCircleLayout implements HLayout {
	private int currentIndex;
	private float angleStep, startAngle;
	private float angleStepRad, startAngleRad;
	private float radius, offsetX, offsetY;
	private boolean rotateTarget;
	private boolean bringTheNoise;
 
	public HCircleLayout() {
		radius = 100;
		offsetX = 0;
		offsetY = 0;
		currentIndex = 0;
		this.angleStep(60.0F);
		this.startAngle(0.0F);
	}
 
	public HCircleLayout currentIndex(int i) {
		currentIndex = i;
		return this;
	}

	public int currentIndex() {
		return currentIndex;
	}

	public HCircleLayout resetIndex() {
		currentIndex = 0;
		return this;
	}

	//set the radius
	public HCircleLayout radius(float f) {
		radius = f;
		return this;
	}
 
	public float radius() {
		return radius;
	}
 
	//set the offset coords
	public HCircleLayout offset(float x, float y) {
		offsetX = x;
		offsetY = y;
		return this;
	}
 
	public HCircleLayout offsetX(float f) {
		offsetX = f;
		return this;
	}
 
	public float offsetX() {
		return offsetX;
	}
 
	public HCircleLayout offsetY(float f) {
		offsetY = f;
		return this;
	}
 
	public float offsetY() {
		return offsetY;
	}
 
	public HCircleLayout angleStep(float f) {
		angleStepRad = radians(f);
		angleStep = f;
		return this;
	}
 
	public float angleStep() {
		return angleStep;
	}
 
	public float angleStepRad() {
		return angleStepRad;
	}
 
	public HCircleLayout startAngle(float f) {
		startAngleRad = radians(f);
		startAngle = f;
		return this;
	}
 
	public float startAngle() {
		return startAngle;
	}
 
	public float startAngleRad() {
		return startAngleRad;
	}
 
	public HCircleLayout rotateTarget(boolean b) {
		rotateTarget = b;
		return this;
	}
 
	public boolean rotateTarget() {
		return rotateTarget;
	}
 
	public HCircleLayout applyNoise(boolean b) {
		bringTheNoise = b;
		return this;
	}
 
	public boolean applyNoise() {
		return bringTheNoise;
	}
 
	@Override
	public PVector getNextPoint() {
 
		float x = radius * cos(startAngleRad + (angleStepRad * currentIndex)) + offsetX;
		float y = radius * sin(startAngleRad + (angleStepRad * currentIndex)) + offsetY;
 
		if(bringTheNoise) {
			//apply some noise
			float nx = H.app().noise(HMath.randomInt(1, 50) * 0.1F, HMath.randomInt(1, 50) * 0.1F);
			float ny = H.app().noise(HMath.randomInt(1, 50) * 0.1F, HMath.randomInt(1, 50) * 0.1F);
 
			float radiusFraction = 0.0F;
			if (radius != 0) {
				radiusFraction = abs(radius) * 0.5F; //50% of radius
			}
 
			nx = map(nx, 0, 1, -radiusFraction, radiusFraction);
			ny = map(ny, 0, 1, -radiusFraction, radiusFraction);
 
			x += nx;
			y += ny;
		}
 
		++currentIndex;
		return new PVector(x, y);
	}
 
	@Override
	public void applyTo(HDrawable target) {
 
		if (rotateTarget) {
			target.rotationZRad(radians(90) + (angleStepRad * currentIndex));
		}
		target.loc(getNextPoint());
 
	}
 
 
}
 
