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
	private float _min1, _min2, _min3;
	private float _rel1, _rel2, _rel3;
	private float _max1, _max2, _max3;
	private float _curr1, _curr2, _curr3;
	private float _origw, _origh, _origd;
	private float _step, _speed, _freq;
	private int _property, _waveform;
	public HOscillator() {
		_speed = _freq = 1;
		_waveform = HConstants.SINE;
		_property = HConstants.Y;
		register();
	}
	/** @deprecated */
	public HOscillator createCopy() {
		HOscillator copy = new HOscillator();
		copy._min1 = _min1;
		copy._min2 = _min2;
		copy._min3 = _min3;
		copy._max1 = _max1;
		copy._max2 = _max2;
		copy._max3 = _max3;
		copy._rel1 = _rel1;
		copy._rel2 = _rel2;
		copy._rel3 = _rel3;
		copy._origw = _origw;
		copy._origh = _origh;
		copy._origd = _origd;
		copy._step = _step;
		copy._speed = _speed;
		copy._freq = _freq;
		copy._property = _property;
		copy._waveform = _waveform;
		return copy;
	}
	public HOscillator target(HDrawable d) {
		_target = d;
		if(d != null) {
			_origw = d.width();
			_origh = d.height();
			_origd = 0;
		}
		return this;
	}
	public HOscillator target(HDrawable3D d) {
		_target = d;
		if(d != null) {
			_origw = d.width();
			_origh = d.height();
			_origd = d.depth();
		}
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
		if (_target instanceof HDrawable3D) {
			return min(a,a,a);
		} else {
			return min(a,a,0);
		}
	}
	public HOscillator min(float a, float b) {
		return min(a,b,0);
	}
	public HOscillator min(float a, float b, float c) {
		_min1 = a;
		_min2 = b;
		_min3 = c;
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
		if (_target instanceof HDrawable3D) {
			return max(a,a,a);
		} else {
			return max(a,a,0);
		}
	}
	public HOscillator max(float a, float b) {
		return max(a,b,0);
	}
	public HOscillator max(float a, float b, float c) {
		_max1 = a;
		_max2 = b;
		_max3 = c;
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
	public float nextRaw() {
		float deg = (_step*_freq) % 360;
		float rawVal;
		switch(_waveform) {
		case HConstants.SINE:		rawVal = HMath.sineWave(deg); break;
		case HConstants.TRIANGLE:	rawVal = HMath.triangleWave(deg); break;
		case HConstants.SAW:		rawVal = HMath.sawWave(deg); break;
		case HConstants.SQUARE:		rawVal = HMath.squareWave(deg); break;
		default: rawVal = 0; break;
		}
		_step += _speed;
		_curr1 = HMath.map(rawVal, -1,1, _min1,_max1) + _rel1;
		_curr2 = HMath.map(rawVal, -1,1, _min2,_max2) + _rel2;
		_curr3 = HMath.map(rawVal, -1,1, _min3,_max3) + _rel3;
		return rawVal;
	}
	public float curr() {
		return _curr1;
	}
	public float curr1() {
		return _curr1;
	}
	public float curr2() {
		return _curr2;
	}
	public float curr3() {
		return _curr3;
	}
	public void runBehavior(PApplet app) {
		if(_target==null) return;
		nextRaw();
		float v1 = _curr1;
		float v2 = _curr2;
		float v3 = _curr3;
		switch(_property) {
		case HConstants.WIDTH:		_target.width(v1); break;
		case HConstants.HEIGHT:		_target.height(v1); break;
		case HConstants.SCALE:
			v1 *= _origw;
			v2 *= _origh;
			v3 *= _origd;
		case HConstants.SIZE: 		_target.size(new PVector(v1, v2, v3)); break;
		case HConstants.ALPHA:		_target.alpha(Math.round(v1)); break;
		case HConstants.X:			_target.x(v1); break;
		case HConstants.Y:			_target.y(v1); break;
		case HConstants.Z:			_target.z(v1); break;
		case HConstants.LOCATION:	_target.loc(v1,v2,v3); break;
		case HConstants.ROTATIONX:	_target.rotationX(v1); break;
		case HConstants.ROTATIONY:	_target.rotationY(v1); break;
		case HConstants.ROTATIONZ:	_target.rotationZ(v1); break;
		case HConstants.DROTATIONX:	_target.rotateX(v1); break;
		case HConstants.DROTATIONY:	_target.rotateY(v1); break;
		case HConstants.DROTATIONZ:	_target.rotateZ(v1); break;
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
