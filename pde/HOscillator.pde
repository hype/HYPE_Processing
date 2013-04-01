

public static class HOscillator extends HBehavior {
	protected HDrawable _target;
	protected float _stepDeg, _speed, _min, _max, _freq, _relValue;
	protected int _propertyId, _waveform;
	
	public HOscillator() {
		_speed = 1;
		_min = -1;
		_max = 1;
		_freq = 1;
		_propertyId = H.Y;
		_waveform = H.SINE;
		
		H.addBehavior(this);
	}
	
	public HOscillator(HDrawable target) {
		this();
		_target = target;
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
		_target = newTarget;
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
	
	public float next() {
		float currentDeg = _stepDeg * _freq;
		
		float outVal = 0;
		switch(_waveform) {
		case H.SINE:	outVal = sineWave(currentDeg);		break;
		case H.TRIANGLE:outVal = triangleWave(currentDeg);	break;
		case H.SAW:		outVal = sawWave(currentDeg);		break;
		case H.SQUARE:	outVal = squareWave(currentDeg);	break;
		}
		outVal = H.app().map(outVal, -1,1, _min,_max) + _relValue;
		
		_stepDeg += speed();
		_stepDeg %= 360;
		return outVal;
	}
	
	public void runBehavior() {
		if(_target != null)
			_target.set(_propertyId, next());
	}
	
	public HOscillator register() {
		return (HOscillator) super.register();
	}
	
	public HOscillator unregister() {
		return (HOscillator) super.unregister();
	}
	
	
	
	public static float sineWave(float stepDegrees) {
		PApplet app = H.app();
		return app.sin(app.radians(stepDegrees));
	}
	
	public static float triangleWave(float stepDegrees) {
		float outVal = (stepDegrees % 180) / 90;
		if(outVal > 1)
			outVal = 2-outVal;
		if(stepDegrees % 360 > 180)
			outVal = -outVal;
		return outVal;
	}
	
	public static float sawWave(float stepDegrees) {
		float outVal = (stepDegrees % 180) / 180;
		if(stepDegrees % 360 >= 180)
			outVal -= 1;
		return outVal;
	}
	
	public static float squareWave(float stepDegrees) {
		return (stepDegrees % 360 > 180)? -1 : 1;
	}
}
