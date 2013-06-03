/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HOscillator extends HBehavior {
	private HDrawable _target;
	private float _min1,_min2,_min3, _rel1,_rel2,_rel3, _max1,_max2,_max3;
	private float _step, _speed, _freq;
	private int _property, _waveform;
	public HOscillator() {
		_speed = _freq = 1;
		_waveform = HConstants.SINE;
		_property = HConstants.Y;
		register();
	}
	public HOscillator target(HDrawable d) {
		_target = d;
		return this;
	}
	public HDrawable target() {
		return _target;
	}
	public HOscillator currentStep(float stepDegrees) {
		_step = stepDegrees;
		return this;
	}
	public float currentStep() {
		return _step;
	}
	public HOscillator speed(float f) {
		_speed = f;
		return this;
	}
	public float speed() {
		return _speed;
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
		return min(a,a);
	}
	public HOscillator min(float a, float b) {
		return min(a,b,0);
	}
	public HOscillator min(float a, float b, float c) {
		_min1 = a;
		_min2 = b;
		_min3 = c;
		if(_property==HConstants.SCALE) {
			if(_target==null) {
				HWarnings.warn(HWarnings.NULL_TARGET,"HOscillator.min()",null);
			} else {
				_min1 *= _target.width();
				_min2 *= _target.height();
			}
		}
		return this;
	}
	public float min() {
		return _min1;
	}
	public float min1() {
		return _min1;
	}
	public float min2() {
		return _min2;
	}
	public float min3() {
		return _min3;
	}
	public HOscillator relativeVal(float a) {
		return relativeVal(a,a);
	}
	public HOscillator relativeVal(float a, float b) {
		return relativeVal(a,b,0);
	}
	public HOscillator relativeVal(float a, float b, float c) {
		_rel1 = a;
		_rel2 = b;
		_rel3 = c;
		if(_property==HConstants.SCALE) {
			if(_target==null) {
				HWarnings.warn(HWarnings.NULL_TARGET,
					"HOscillator.relativeVal()",null);
			} else {
				_rel1 *= _target.width();
				_rel2 *= _target.height();
			}
		}
		return this;
	}
	public float relativeVal() {
		return _rel1;
	}
	public float relativeVal1() {
		return _rel1;
	}
	public float relativeVal2() {
		return _rel2;
	}
	public float relativeVal3() {
		return _rel3;
	}
	public HOscillator max(float a) {
		return max(a,a);
	}
	public HOscillator max(float a, float b) {
		return max(a,b,0);
	}
	public HOscillator max(float a, float b, float c) {
		_max1 = a;
		_max2 = b;
		_max3 = c;
		if(_property==HConstants.SCALE) {
			if(_target==null) {
				HWarnings.warn(HWarnings.NULL_TARGET,"HOscillator.max()",null);
			} else {
				_max1 *= _target.width();
				_max2 *= _target.height();
			}
		}
		return this;
	}
	public float max() {
		return _max1;
	}
	public float max1() {
		return _max1;
	}
	public float max2() {
		return _max2;
	}
	public float max3() {
		return _max3;
	}
	public HOscillator freq(float f) {
		_freq = f;
		return this;
	}
	public float freq() {
		return _freq;
	}
	public HOscillator property(int id) {
		_property = id;
		return this;
	}
	public int property() {
		return _property;
	}
	public HOscillator waveform(int waveformId) {
		_waveform = waveformId;
		return this;
	}
	public int waveform() {
		return _waveform;
	}
	public void runBehavior(PApplet app) {
		if(_target==null) return;
		float deg = (_step*_freq) % 359;
		float curr;
		switch(_waveform) {
		case HConstants.SINE:		curr = HMath.sineWave(deg); break;
		case HConstants.TRIANGLE:	curr = HMath.triangleWave(deg); break;
		case HConstants.SAW:		curr = HMath.sawWave(deg); break;
		case HConstants.SQUARE:		curr = HMath.squareWave(deg); break;
		default: curr = 0; break;
		}
		_step += _speed;
		float v1 = HMath.map(curr, -1,1, _min1,_max1) + _rel1;
		float v2 = HMath.map(curr, -1,1, _min2,_max2) + _rel2;
		float v3 = HMath.map(curr, -1,1, _min3,_max3) + _rel3;
		switch(_property) {
		case HConstants.WIDTH:		_target.width(v1); break;
		case HConstants.HEIGHT:		_target.height(v1); break;
		case HConstants.SCALE:		
		case HConstants.SIZE:		_target.size(v1,v2); break;
		case HConstants.ALPHA:		_target.alpha(Math.round(v1)); break;
		case HConstants.X:			_target.x(v1); break;
		case HConstants.Y:			_target.y(v1); break;
		case HConstants.Z:			_target.z(v1); break;
		case HConstants.LOCATION:	_target.loc(v1,v2,v3); break;
		case HConstants.ROTATION:	_target.rotation(v1); break;
		case HConstants.DROTATION:	_target.rotate(v1); break;
		case HConstants.DX:			_target.move(v1,0); break;
		case HConstants.DY:			_target.move(0,v1); break;
		case HConstants.DLOC:		_target.move(v1,v1); break;
		default: break;
		}
	}
	public HOscillator register() {
		return (HOscillator) super.register();
	}
	public HOscillator unregister() {
		return (HOscillator) super.unregister();
	}
}
