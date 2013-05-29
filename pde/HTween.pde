public static class HTween extends HBehavior {
	private HDrawable _target;
	private HCallback _callback;
	private float _s1,_s2,_s3, _e1,_e2,_e3;
	private float _curr, _dcurr, _spring, _ease;
	private int _property;
	public HTween() {
		_ease = 1;
	}
	public HTween target(HDrawable d) {
		registered(d != null);
		_target = d;
		return this;
	}
	public HDrawable target() {
		return _target;
	}
	public HTween callback(HCallback c) {
		_callback = c;
		return this;
	}
	public HCallback callback() {
		return _callback;
	}
	private void setScaleStart() {
		if(_property!=HConstants.SCALE) return;
		if(_target==null) {
			HWarnings.warn(HWarnings.NULL_TARGET,"HTween.start()",null);
		} else {
			_s1 *= _target.width();
			_s2 *= _target.height();
		}
	}
	public HTween start(float a) {
		_s1 = _s2 = a;
		setScaleStart();
		return this;
	}
	public HTween start(float a, float b) {
		_s1 = a;
		_s2 = b;
		setScaleStart();
		return this;
	}
	public HTween start(float a, float b, float c) {
		_s1 = a;
		_s2 = b;
		_s3 = c;
		setScaleStart();
		return this;
	}
	private void setScaleEnd() {
		if(_property!=HConstants.SCALE) return;
		if(_target==null) {
			HWarnings.warn(HWarnings.NULL_TARGET,"HTween.end()",null);
		} else {
			_e1 *= _target.width();
			_e2 *= _target.height();
		}
	}
	public HTween end(float a) {
		_e1 = _e2 = a;
		setScaleEnd();
		return this;
	}
	public HTween end(float a, float b) {
		_e1 = a;
		_e2 = b;
		setScaleEnd();
		return this;
	}
	public HTween end(float a, float b, float c) {
		_e1 = a;
		_e2 = b;
		_e3 = c;
		setScaleEnd();
		return this;
	}
	public HTween spring(float f) {
		_spring = f;
		return this;
	}
	public float spring() {
		return _spring;
	}
	public HTween ease(float f) {
		_ease = f;
		return this;
	}
	public float ease() {
		return _ease;
	}
	public HTween property(int id) {
		_property = id;
		return this;
	}
	public int property() {
		return _property;
	}
	public void runBehavior(PApplet app) {
		if(_target==null) return;
		_curr += (_dcurr) = (_dcurr*_spring + (1-_curr)*_ease);
		float c = HMath.round512(_curr);
		float v1 = HMath.map(c,0,1,_s1,_e1);
		float v2 = HMath.map(c,0,1,_s2,_e2);
		float v3 = HMath.map(c,0,1,_s3,_e3);
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
		if(c==1 && HMath.round512(_dcurr)==0) {
			unregister();
			if(_callback != null) _callback.run(this);
		}
	}
	public HTween register() {
		return (HTween) super.register();
	}
	public HTween unregister() {
		_curr = _dcurr = 0;
		return (HTween) super.unregister();
	}
}
