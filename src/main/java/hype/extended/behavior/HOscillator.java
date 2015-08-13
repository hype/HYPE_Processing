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
	private HDrawable _target;
	private float _min1, _min2, _min3;
	private float _rel1, _rel2, _rel3;
	private float _max1, _max2, _max3;
	private float _curr1, _curr2, _curr3;
	private float _map1, _map2, _map3;
	private float _origw, _origh, _origd;
	private float _step, _speed, _freq;
	private float _clip_min, _clip_max;
	private float _offset;
	private boolean _clip;
	private int _property, _waveform, _tick;
	private float _startStep;

	private ArrayList<HOscillator> _amplifiers, _reducers;

	public HOscillator() {
		_clip = false;
		_speed = _freq = 1;
		_waveform = HConstants.SINE;
		_property = HConstants.Y;

		_amplifiers = new ArrayList<HOscillator>();
		_reducers = new ArrayList<HOscillator>();
		_offset = 0;

		_tick = 0;
		_startStep = 0;

		register();
	}

	public HOscillator addAmplifier(HOscillator wave) {
		_amplifiers.add(wave);
		return this;
	}

	public HOscillator addReducer(HOscillator wave) {
		_reducers.add(wave);
		return this;
	}

	public HOscillator clipping(float clipMin, float clipMax) {
		_clip = true;
		_clip_min = clipMin;
		_clip_max = clipMax;
		return this;
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
		_startStep = stepDegrees;
		return this;
	}

	public float currentStep() {
		return _step;
	}

	public HOscillator synchStep(float stepDegrees, float tick) {
		currentStep(stepDegrees + tick * _speed);
		return this;
	}

	public HOscillator offset(float offset) {
		_offset = offset;
		return this;
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

		_map1 = HMath.map(rawVal, -1,1, _min1,_max1);
		_map2 = HMath.map(rawVal, -1,1, _min2,_max2);
		_map3 = HMath.map(rawVal, -1,1, _min3,_max3);

		//deal with amplifier waves
		if (_amplifiers.size() > 0) {
			for (int i = _amplifiers.size()-1; i >= 0; i--) {
				HOscillator amplifier = _amplifiers.get(i);
				amplifier.synchStep(_startStep, _tick);
				amplifier.nextRaw();

				_map1 += amplifier.map1();
				_map2 += amplifier.map2();
				_map3 += amplifier.map3();
			}
		}

		//deal with reducer waves
		if (_reducers.size() > 0) {
			for (int i = _reducers.size()-1; i >= 0; i--) {
				HOscillator reducer = _reducers.get(i);
				reducer.synchStep(_startStep, _tick);
				reducer.nextRaw();

				_map1 -= reducer.map1();
				_map2 -= reducer.map2();
				_map3 -= reducer.map3();
			}
		}

		//handle clipping
		if (_clip) {
			if (_map1 > _clip_max) {
				_map1 = _clip_max;
			}
			if (_map2 > _clip_max) {
				_map2 = _clip_max;
			}
			if (_map3 > _clip_max) {
				_map3 = _clip_max;
			}

			if (_map1 < _clip_min) {
				_map1 = _clip_min;
			}
			if (_map2 < _clip_min) {
				_map2 = _clip_min;
			}
			if (_map3 < _clip_min) {
				_map3 = _clip_min;
			}
		}

		_map1 += _offset;
		_map2 += _offset;
		_map3 += _offset;

		_curr1 = _map1 + _rel1;
		_curr2 = _map2 + _rel2;
		_curr3 = _map3 + _rel3;

		_step += _speed;
		_tick++;

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

	public float map1() {
		return _map1;
	}

	public float map2() {
		return _map2;
	}

	public float map3() {
		return _map3;
	}

	@Override
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

	@Override
	public HOscillator register() {
		return (HOscillator) super.register();
	}

	@Override
	public HOscillator unregister() {
		return (HOscillator) super.unregister();
	}
}
