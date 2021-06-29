package hype.extended.behavior;

import hype.H;
import hype.HBehavior;
import hype.HDrawable;
import hype.HDrawable3D;
import hype.interfaces.HConstants;
import hype.HMath;

import static processing.core.PApplet.radians;

import processing.core.PApplet;
import processing.core.PVector;



public class HNoiseLoop extends HBehavior {
	private HDrawable target;
	private int property, startStep, curStep;

	private float noiseDetailX, noiseDetailY;
	private float radius, stepSize, loopLength, _frameRate;

	private float min1, min2, min3;
	private float rel1, rel2, rel3;
	private float max1, max2, max3;
	private float curr1, curr2, curr3;
	private float map1, map2, map3;
	private float origw, origh, origd;

	private float contrastAmt   = 80.0f;
	private boolean useContrast = false;

	private boolean clockwise = true;
	private float direction = 1.0f;


	public HNoiseLoop() {

		//noise settings
		noiseDetailX = 0.005f;
		noiseDetailY = 0.005f;

		radius = 100.0f;
		
		property = HConstants.Y;
		startStep = 0;
		curStep = 0;

		loopLength = 5.0f;
		_frameRate = 60.0f;
		stepSize = 360.0f / (loopLength * _frameRate);
		
		register();
	}

	/** @deprecated */
	public HNoiseLoop createCopy() {
		HNoiseLoop copy = new HNoiseLoop();
		copy.property = property;
		return copy;
	}

	/*
		set and get the target drawable/drawable3D
	*/
	public HNoiseLoop target(HDrawable d) {
		target = d;
		if(d != null) {
			origw = d.width();
			origh = d.height();
			origd = 0;
		}
		return this;
	}

	public HNoiseLoop target(HDrawable3D d) {
		target = d;
		if(d != null) {
			origw = d.width();
			origh = d.height();
			origd = d.depth();
		}
		return this;
	}

	public HDrawable target() {
		return target;
	}

	public HNoiseLoop currentStep(int s) {
		curStep = s;
		startStep = s;
		return this;
	}

	public int currentStep() {
		return curStep;
	}


	public HNoiseLoop radius(float r) {
		radius = r;
		return this;
	}

	public float radius() {
		return radius;
	}






	public HNoiseLoop noiseDetail(float d) {
		noiseDetailX = d;
		noiseDetailY = d;
		return this;
	}
	
	public float noiseDetail() {
		return noiseDetailX;
	}


	public HNoiseLoop noiseDetailX(float d) {
		noiseDetailX = d;
		return this;
	}
	
	public float noiseDetailX() {
		return noiseDetailX;
	}

	public HNoiseLoop noiseDetailY(float d) {
		noiseDetailY = d;
		return this;
	}
	
	public float noiseDetailY() {
		return noiseDetailY;
	}

	

	public HNoiseLoop loopLength(float l) {
		loopLength = l;
		stepSize = 360.0f / (loopLength * _frameRate);
		return this;
	}

	public float loopLength() {
		return loopLength;
	}


	public HNoiseLoop frameRate(float f) {
		_frameRate = f;
		stepSize = 360.0f / (loopLength * _frameRate);
		return this;
	}

	public float frameRate() {
		return _frameRate;
	}

	public HNoiseLoop useContrast(boolean b) {
		useContrast = b;
		return this;
	}
	public boolean useContrast() {
		return useContrast;
	}

	public HNoiseLoop contrast(float c) {
		contrastAmt = (float)Math.max((float)Math.min(c, 255.0f), -255.0f);
		return this;
	}
	public float contrast() {
		return contrastAmt;
	}

	private float applyContrast(float grey) {
		float factor = (259 * (contrastAmt + 255)) / (255 * (259 - contrastAmt));
		float newGrey = factor * (grey - 0.5f) + 0.5f;
		return (float)Math.max((float)Math.min(newGrey, 1.0f), 0.0f);
	}

	
	public HNoiseLoop clockwise(boolean b) {
		clockwise = b;
		if (clockwise) {
			direction = 1.0f;
		} else {
			direction = -1.0f;
		}
		return this;
	}
	public boolean clockwise() {
		return clockwise;
	}


	public HNoiseLoop range(float minimum, float maximum) {
		return min(minimum).max(maximum);
	}

	public HNoiseLoop range(
		float minA, float minB,
		float maxA, float maxB
	) {
		return min(minA,minB).max(maxA,maxB);
	}

	public HNoiseLoop range(
		float minA, float minB, float minC,
		float maxA, float maxB, float maxC
	) {
		return min(minA,minB,minC).max(maxA,maxB,maxC);
	}

	public HNoiseLoop min(float a) {
		if (target instanceof HDrawable3D) {
			return min(a,a,a);
		} else {
			return min(a,a,0);
		}
	}

	public HNoiseLoop min(float a, float b) {
		return min(a,b,0);
	}

	public HNoiseLoop min(float a, float b, float c) {
		min1 = a;
		min2 = b;
		min3 = c;
		return this;
	}

	public float min() {
		return min1;
	}

	public float min1() {
		return min1;
	}

	public float min2() {
		return min2;
	}

	public float min3() {
		return min3;
	}

	public HNoiseLoop relativeVal(float a) {
		return relativeVal(a,a);
	}

	public HNoiseLoop relativeVal(float a, float b) {
		return relativeVal(a,b,0);
	}

	public HNoiseLoop relativeVal(float a, float b, float c) {
		rel1 = a;
		rel2 = b;
		rel3 = c;
		return this;
	}

	public float relativeVal() {
		return rel1;
	}

	public float relativeVal1() {
		return rel1;
	}

	public float relativeVal2() {
		return rel2;
	}

	public float relativeVal3() {
		return rel3;
	}

	public HNoiseLoop max(float a) {
		if (target instanceof HDrawable3D) {
			return max(a,a,a);
		} else {
			return max(a,a,0);
		}
	}

	public HNoiseLoop max(float a, float b) {
		return max(a,b,0);
	}

	public HNoiseLoop max(float a, float b, float c) {
		max1 = a;
		max2 = b;
		max3 = c;
		return this;
	}

	public float max() {
		return max1;
	}

	public float max1() {
		return max1;
	}

	public float max2() {
		return max2;
	}

	public float max3() {
		return max3;
	}


	
	/*
		relates to the drawable property i.e. x, y, z, width, height etc.
	*/
	public HNoiseLoop property(int id) {
		property = id;
		return this;
	}

	public int property() {
		return property;
	}


	/*
		get next raw value
	*/
	public float nextRaw() {

		float targetX = (float)Math.cos(radians((startStep + curStep) * stepSize)) * radius;
  		float targetY = (float)Math.sin(radians((startStep + curStep) * stepSize)) * radius;

		float rawVal = H.app().noise(targetX*noiseDetailX, targetY*noiseDetailY);

		if (useContrast) {
			rawVal = applyContrast(rawVal);
		}

		map1 = HMath.map(rawVal, 0.0f, 1.0f, min1, max1);
		map2 = HMath.map(rawVal, 0.0f, 1.0f, min2, max2);
		map3 = HMath.map(rawVal, 0.0f, 1.0f, min3, max3);

		curr1 = map1 + rel1;
		curr2 = map2 + rel2;
		curr3 = map3 + rel3;

		curStep += direction;

		return rawVal;
	}


	public float curr() {
		return curr1;
	}

	public float curr1() {
		return curr1;
	}

	public float curr2() {
		return curr2;
	}

	public float curr3() {
		return curr3;
	}

	public float map1() {
		return map1;
	}

	public float map2() {
		return map2;
	}

	public float map3() {
		return map3;
	}


	@Override
	public void runBehavior(PApplet app) {
		if(target ==null) return;

		//FIX FOR H.SCALE AND METHOD CHAINING ON HBOX
		if (target instanceof HDrawable3D) {
			if (max2 != max3) {
				max3=max2;
			}
			if (min2 != min3) {
				min3=min2;
			}
		}

		nextRaw();
		float v1 = curr1;
		float v2 = curr2;
		float v3 = curr3;

		switch(property) {
		case HConstants.WIDTH:		target.width(v1); break;
		case HConstants.HEIGHT:		target.height(v1); break;
		case HConstants.SCALE:
			v1 *= origw;
			v2 *= origh;
			v3 *= origd;
		case HConstants.SIZE: 		target.size(new PVector(v1, v2, v3)); break;
		case HConstants.ALPHA:		target.alpha(Math.round(v1)); break;
		case HConstants.X:			target.x(v1); break;
		case HConstants.Y:			target.y(v1); break;
		case HConstants.Z:			target.z(v1); break;
		case HConstants.LOCATION:	target.loc(v1, v2, v3); break;
		case HConstants.ROTATIONX:	target.rotationX(v1); break;
		case HConstants.ROTATIONY:	target.rotationY(v1); break;
		case HConstants.ROTATIONZ:	target.rotationZ(v1); break;
		case HConstants.DROTATIONX:	target.rotateX(v1); break;
		case HConstants.DROTATIONY:	target.rotateY(v1); break;
		case HConstants.DROTATIONZ:	target.rotateZ(v1); break;
		case HConstants.DX:			target.move(v1, 0); break;
		case HConstants.DY:			target.move(0, v1); break;
		case HConstants.DLOC:		target.move(v1, v1); break;
		default: break;
		}
	}

	@Override
	public HNoiseLoop register() {
		return (HNoiseLoop) super.register();
	}

	@Override
	public HNoiseLoop unregister() {
		return (HNoiseLoop) super.unregister();
	}
}
