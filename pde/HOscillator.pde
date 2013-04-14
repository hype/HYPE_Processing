public static class HOscillator extends HBehavior {
	protected HDrawable _target;
	protected float
		_stepDeg, _speed, _min,
		_max, _freq, _relValue,
		_origW, _origH;
	protected int _propertyId, _waveform;
	public HOscillator() {
		_speed = 1;
		_min = -1;
		_max = 1;
		_freq = 1;
		_propertyId = H.Y;
		_waveform = H.SINE;
	}
	public HOscillator(HDrawable newTarget) {
		this();
		target(newTarget);
	}
	public HOscillator createCopy() {
		HOscillator osc = new HOscillator()
			.currentStep(_stepDeg)
			.speed(_speed)
			.range(_min, _max)
			.freq(_freq)
			.relativeVal(_relValue)
			.property(_propertyId)
			.waveform(_waveform);
		return osc;
	}
	public HOscillator target(HDrawable newTarget) {
		if(newTarget == null) unregister();
		else register();
		_target = newTarget;
		if(_target != null) {
			_origW = _target.width();
			_origH = _target.height();
		}
		return this;
	}
	public HDrawable target() {
		return _target;
	}
	public HOscillator currentStep(float stepDegrees) {
		_stepDeg = stepDegrees;
		return this;
	}
	public float currentStep() {
		return _stepDeg;
	}
	public HOscillator speed(float spd) {
		_speed = spd;
		return this;
	}
	public float speed() {
		return _speed;
	}
	public HOscillator range(float minimum, float maximum) {
		_min = minimum;
		_max = maximum;
		return this;
	}
	public HOscillator min(float minimum) {
		_min = minimum;
		return this;
	}
	public float min() {
		return _min;
	}
	public HOscillator max(float maximum) {
		_max = maximum;
		return this;
	}
	public float max() {
		return _max;
	}
	public HOscillator freq(float frequency) {
		_freq = frequency;
		return this;
	}
	public float freq() {
		return _freq;
	}
	public HOscillator relativeVal(float relativeValue) {
		_relValue = relativeValue;
		return this;
	}
	public float relativeVal() {
		return _relValue;
	}
	public HOscillator property(int propertyId) {
		_propertyId = propertyId;
		return this;
	}
	public int property() {
		return _propertyId;
	}
	public HOscillator waveform(int form) {
		_waveform = form;
		return this;
	}
	public int waveform() {
		return _waveform;
	}
	public float nextVal() {
		float currentDeg = _stepDeg * _freq;
		float outVal = 0;
		switch(_waveform) {
		case H.SINE:	outVal = HMath.sineWave(currentDeg);	break;
		case H.TRIANGLE:outVal = HMath.triangleWave(currentDeg);break;
		case H.SAW:		outVal = HMath.sawWave(currentDeg);		break;
		case H.SQUARE:	outVal = HMath.squareWave(currentDeg);	break;
		}
		outVal = H.app().map(outVal, -1,1, _min,_max) + _relValue;
		_stepDeg += speed();
		return outVal;
	}
	public void runBehavior(PApplet app) {
		if(_target == null) return;
		if(_propertyId == H.SCALE) { 
			float val = nextVal();
			_target.size(_origW*val, _origH*val);
		} else {
			H.setProperty(_target, _propertyId, nextVal());
		}
	}
	public HOscillator register() {
		return (HOscillator) super.register();
	}
	public HOscillator unregister() {
		return (HOscillator) super.unregister();
	}
}
