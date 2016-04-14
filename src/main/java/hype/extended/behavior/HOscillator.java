package hype.extended.behavior;

import hype.HBehavior;
import hype.HDrawable;
import hype.HDrawable3D;
import hype.interfaces.HConstants;
import hype.HMath;
import processing.core.PApplet;
import processing.core.PVector;

import java.util.ArrayList;

public class HOscillator extends HBehavior {
	private HDrawable target;
	private float min1, min2, min3;
	private float rel1, rel2, rel3;
	private float max1, max2, max3;
	private float curr1, curr2, curr3;
	private float map1, map2, map3;
	private float origw, origh, origd;
	private float step, speed, freq;
	private float clip_min, _clip_max;
	private float offset;
	private boolean clip;
	private int property, waveform, tick;
	private float startStep;

	private ArrayList<HOscillator> amplifiers, reducers;

	public HOscillator() {
		clip = false;
		speed = freq = 1;
		waveform = HConstants.SINE;
		property = HConstants.Y;

		amplifiers = new ArrayList<HOscillator>();
		reducers = new ArrayList<HOscillator>();
		offset = 0;

		tick = 0;
		startStep = 0;

		register();
	}

	public HOscillator addAmplifier(HOscillator wave) {
		amplifiers.add(wave);
		return this;
	}

	public HOscillator addReducer(HOscillator wave) {
		reducers.add(wave);
		return this;
	}

	public HOscillator clipping(float clipMin, float clipMax) {
		clip = true;
		this.clip_min = clipMin;
		_clip_max = clipMax;
		return this;
	}

	/** @deprecated */
	public HOscillator createCopy() {
		HOscillator copy = new HOscillator();
		copy.min1 = min1;
		copy.min2 = min2;
		copy.min3 = min3;
		copy.max1 = max1;
		copy.max2 = max2;
		copy.max3 = max3;
		copy.rel1 = rel1;
		copy.rel2 = rel2;
		copy.rel3 = rel3;
		copy.origw = origw;
		copy.origh = origh;
		copy.origd = origd;
		copy.step = step;
		copy.speed = speed;
		copy.freq = freq;
		copy.property = property;
		copy.waveform = waveform;
		return copy;
	}

	public HOscillator target(HDrawable d) {
		target = d;
		if(d != null) {
			origw = d.width();
			origh = d.height();
			origd = 0;
		}
		return this;
	}

	public HOscillator target(HDrawable3D d) {
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

	public HOscillator currentStep(float stepDegrees) {
		step = stepDegrees;
		startStep = stepDegrees;
		return this;
	}

	public float currentStep() {
		return step;
	}

	public HOscillator synchStep(float stepDegrees, float tick) {
		currentStep(stepDegrees + tick * speed);
		return this;
	}

	public HOscillator offset(float offset) {
		this.offset = offset;
		return this;
	}

	public HOscillator speed(float f) {
		speed = f;
		return this;
	}

	public float speed() {
		return speed;
	}

	public HOscillator range(float minimum, float maximum) {
		return min(minimum).max(maximum);
	}

	public HOscillator range(
		float minA, float minB,
		float maxA, float maxB
	) {
		return min(minA,minB).max(maxA,maxB);
	}

	public HOscillator range(
		float minA, float minB, float minC,
		float maxA, float maxB, float maxC
	) {
		return min(minA,minB,minC).max(maxA,maxB,maxC);
	}

	public HOscillator min(float a) {
		if (target instanceof HDrawable3D) {
			return min(a,a,a);
		} else {
			return min(a,a,0);
		}
	}

	public HOscillator min(float a, float b) {
		return min(a,b,0);
	}

	public HOscillator min(float a, float b, float c) {
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

	public HOscillator relativeVal(float a) {
		return relativeVal(a,a);
	}

	public HOscillator relativeVal(float a, float b) {
		return relativeVal(a,b,0);
	}

	public HOscillator relativeVal(float a, float b, float c) {
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

	public HOscillator max(float a) {
		if (target instanceof HDrawable3D) {
			return max(a,a,a);
		} else {
			return max(a,a,0);
		}
	}

	public HOscillator max(float a, float b) {
		return max(a,b,0);
	}

	public HOscillator max(float a, float b, float c) {
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

	public HOscillator freq(float f) {
		freq = f;
		return this;
	}

	public float freq() {
		return freq;
	}

	public HOscillator property(int id) {
		property = id;
		return this;
	}

	public int property() {
		return property;
	}

	public HOscillator waveform(int waveformId) {
		waveform = waveformId;
		return this;
	}

	public int waveform() {
		return waveform;
	}

	public float nextRaw() {
		float deg = (step * freq) % 360;
		float rawVal;
		switch(waveform) {
		case HConstants.SINE:		rawVal = HMath.sineWave(deg); break;
		case HConstants.TRIANGLE:	rawVal = HMath.triangleWave(deg); break;
		case HConstants.SAW:		rawVal = HMath.sawWave(deg); break;
		case HConstants.SQUARE:		rawVal = HMath.squareWave(deg); break;
		default: rawVal = 0; break;
		}

		map1 = HMath.map(rawVal, -1,1, min1, max1);
		map2 = HMath.map(rawVal, -1,1, min2, max2);
		map3 = HMath.map(rawVal, -1,1, min3, max3);

		//deal with amplifier waves
		if (amplifiers.size() > 0) {
			for (int i = amplifiers.size()-1; i >= 0; i--) {
				HOscillator amplifier = amplifiers.get(i);
				amplifier.synchStep(startStep, tick);
				amplifier.nextRaw();

				map1 += amplifier.map1();
				map2 += amplifier.map2();
				map3 += amplifier.map3();
			}
		}

		//deal with reducer waves
		if (reducers.size() > 0) {
			for (int i = reducers.size()-1; i >= 0; i--) {
				HOscillator reducer = reducers.get(i);
				reducer.synchStep(startStep, tick);
				reducer.nextRaw();

				map1 -= reducer.map1();
				map2 -= reducer.map2();
				map3 -= reducer.map3();
			}
		}

		//handle clipping
		if (clip) {
			if (map1 > _clip_max) {
				map1 = _clip_max;
			}
			if (map2 > _clip_max) {
				map2 = _clip_max;
			}
			if (map3 > _clip_max) {
				map3 = _clip_max;
			}

			if (map1 < clip_min) {
				map1 = clip_min;
			}
			if (map2 < clip_min) {
				map2 = clip_min;
			}
			if (map3 < clip_min) {
				map3 = clip_min;
			}
		}

		map1 += offset;
		map2 += offset;
		map3 += offset;

		curr1 = map1 + rel1;
		curr2 = map2 + rel2;
		curr3 = map3 + rel3;

		step += speed;
		tick++;

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
	public HOscillator register() {
		return (HOscillator) super.register();
	}

	@Override
	public HOscillator unregister() {
		return (HOscillator) super.unregister();
	}
}
