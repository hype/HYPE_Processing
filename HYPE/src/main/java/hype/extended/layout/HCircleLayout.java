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
	private float radius, startX, startY, startZ;
	private boolean rotateTarget;
	private boolean useNoise;
 
	public HCircleLayout() {
		radius = 100;
		startX = 0;
		startY = 0;
		startZ = 0;
		currentIndex = 0;
		this.angleStep(60.0F);
		this.startAngle(0.0F);
	}
 
	public PVector startLoc() {
		return new PVector(startX, startY, startZ);
	}

	public HCircleLayout startLoc(float x, float y) {
		startX = x;
		startY = y;
		startZ = 0;
		return this;
	}

	public HCircleLayout startLoc(float x, float y, float z) {
		startX = x;
		startY = y;
		startZ = z;
		return this;
	}

	public float startX() {
		return startX;
	}

	public HCircleLayout startX(float x) {
		startX = x;
		return this;
	}

	public float startY() {
		return startY;
	}

	public HCircleLayout startY(float y) {
		startY = y;
		return this;
	}

	public float startZ() {
		return startZ;
	}

	public HCircleLayout startZ(float z) {
		startZ = z;
		return this;
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
 

 	//change this
	public HCircleLayout useNoise(boolean b) {
		useNoise = b;
		return this;
	}
 
	public boolean useNoise() {
		return useNoise;
	}

	float getRotation() {
		return 90.0f + (angleStep * currentIndex);
	}

	float getRotation(int step) {
		return 90.0f + (angleStep * step);
	}

	float getRotationRadians() {
		return radians(90) + (angleStepRad * currentIndex);
	}

	float getRotationRadians(int step) {
		return radians(90) + (angleStepRad * step);
	}

 
	@Override
	public PVector getNextPoint() {

		float a = startAngleRad + (angleStepRad * currentIndex);

		float r = radius;
		if (useNoise) {
			float n = H.app().noise(0.1f * currentIndex);
			n = map(n, 0.0f, 1.0f, -1.0f, 1.0f);

			r = radius + 150 * n;
		}
 
		float x = r * cos(a) + startX;
		float y = r * sin(a) + startY;
		float z = startZ;
 
 		/*
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
		}*/
 
		++currentIndex;
		return new PVector(x, y, z);
	}
 
	@Override
	public void applyTo(HDrawable target) {
 
		if (rotateTarget) {
			target.rotationZRad(radians(90) + (angleStepRad * currentIndex));
		}
		target.loc(getNextPoint());
 
	}
 
 
}
 
