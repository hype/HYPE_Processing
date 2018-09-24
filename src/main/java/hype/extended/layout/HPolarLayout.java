package hype.extended.layout;

import hype.interfaces.HLayout;
import hype.H;
import hype.HDrawable;
import hype.HMath;

import processing.core.PVector;

import static processing.core.PApplet.cos;
import static processing.core.PApplet.sin;

public class HPolarLayout implements HLayout {

	private int currentIndex;
	private float length, angleStep, scaleMultiplier, offsetX, offsetY;
	private Boolean scaleByDistance;

	public HPolarLayout() {
		currentIndex = 0;
		length = 1;
		angleStep = (float) 0.1;
		offsetX = 0;
		offsetY = 0;
		scaleByDistance = false;
		scaleMultiplier = 0;
	}
	
	public HPolarLayout(float length, float angleStep) {
		currentIndex = 0;
		this.length = length;
		this.angleStep = angleStep;
		offsetX = 0;
		offsetY = 0;
		scaleByDistance = false;
		scaleMultiplier = 0;
	}

	public HPolarLayout currentIndex(int i) {
		currentIndex = i;
		return this;
	}

	public int currentIndex() {
		return currentIndex;
	}

	public HPolarLayout resetIndex() {
		currentIndex = 0;
		return this;
	}

	//set the offset coords
	public HPolarLayout offset(float x, float y) {
		offsetX = x;
		offsetY = y;
		return this;
	}

	public HPolarLayout offsetX(float f) {
		offsetX = f;
		return this;
	}

	public float offsetX() {
		return offsetX;
	}

	public HPolarLayout offsetY(float f) {
		offsetY = f;
		return this;
	}

	public float offsetY() {
		return offsetY;
	}

	public HPolarLayout length(float f) {
		length = f;
		return this;
	}

	public float length() {
		return length;
	}

	public HPolarLayout angleStep(float f) {
		angleStep = f;
		return this;
	}

	public float angleStep() {
		return angleStep;
	}

	//turn on distance scaling by multiplier f
	public HPolarLayout scale(float f) {
		scaleByDistance = true;
		scaleMultiplier = f;
		return this;
	}

	private void applyScale(HDrawable target) {
		float d = HMath.dist(offsetX, offsetY, target.x(), target.y());
		target.scale(d * scaleMultiplier);
	}

	@Override
	public PVector getNextPoint() {
		PVector pt = new PVector();
		
		float r     = currentIndex * length;
		float theta = currentIndex * angleStep;

		pt.x = r * cos(theta) + offsetX;
		pt.y = r * sin(theta) + offsetY;

		++currentIndex;

		return pt;
	}

	@Override
	public void applyTo(HDrawable target) {
		target.loc(getNextPoint());
		
		if (scaleByDistance == true) {
			applyScale(target);
		}
	}
	
}
