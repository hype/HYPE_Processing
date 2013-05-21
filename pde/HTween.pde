public static class HTween extends HBehavior {
	private HDrawable _target;
	private HCallback _callback;
	private float[] _starts, _ends;
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
	public HTween start(float... fs) {
		int numVals;
		switch(_property) {
		case HConstants.LOCATION:
		case HConstants.DLOC:
			numVals = 3; break;
		case HConstants.SIZE:
			numVals = 2; break;
		default:
			numVals = 1; break;
		}
		if(_property==HConstants.SCALE) {
			if(_starts==null||_starts.length<2) _starts = new float[2];
			if(_target!=null) {
				_starts[0] = _target.width() * fs[0];
				_starts[1] = _target.height() * fs[0];
			}
		} else {
			if(_starts==null||_starts.length<numVals) _starts = new float[numVals];
			int numInput = (_starts.length<fs.length)?_starts.length : fs.length;
			for(int i=0; i<numInput; ++i) _starts[i] = fs[i];
		}
		_curr = 0;
		return this;
	}
	public HTween end(float... fs) {
		int numVals;
		switch(_property) {
		case HConstants.LOCATION:
		case HConstants.DLOC:
			numVals = 3; break;
		case HConstants.SIZE:
		case HConstants.SCALE:
			numVals = 2; break;
		default:
			numVals = 1; break;
		}
		if(_property==HConstants.SCALE) {
			if(_ends==null||_ends.length<2) _ends = new float[2];
			if(_target!=null) {
				_ends[0] = _target.width() * fs[0];
				_ends[1] = _target.height() * fs[0];
			}
		} else {
			if(_ends==null||_ends.length<numVals) _ends = new float[numVals];
			int numInput = (_ends.length<fs.length)? _ends.length : fs.length;
			for(int i=0; i<numInput; ++i) _ends[i] = fs[i];
		}
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
		_curr += _dcurr = _dcurr*_spring + (1-_curr)*_ease;
		float v1 = HMath.map(_curr, 0,1, _starts[0],_ends[0]);
		switch(_property) {
		case HConstants.WIDTH:		_target.width(v1); break;
		case HConstants.HEIGHT:		_target.height(v1); break;
		case HConstants.SIZE: {
			float v2 = HMath.map(_curr, 0,1, _starts[1],_ends[1]);
			_target.size(v1,v2);
			} break;
		case HConstants.ALPHA:		_target.alpha(Math.round(v1)); break;
		case HConstants.X:			_target.x(v1); break;
		case HConstants.Y:			_target.y(v1); break;
		case HConstants.Z:			_target.z(v1); break;
		case HConstants.LOCATION: {
			float v2 = HMath.map(_curr, 0,1, _starts[1],_ends[1]);
			float v3 = HMath.map(_curr, 0,1, _starts[2],_ends[2]);
			_target.loc(v1,v2,v3);
			} break;
		case HConstants.ROTATION:	_target.rotation(v1); break;
		case HConstants.DROTATION:	_target.rotate(v1); break;
		case HConstants.DX:			_target.move(v1,0); break;
		case HConstants.DY:			_target.move(0,v1); break;
		case HConstants.DLOC:		_target.move(v1,v1); break;
		case HConstants.SCALE: {
			float v2 = HMath.map(_curr, 0,1, _starts[1],_ends[1]);
			_target.size(v1,v2);
			} break;
		default: break;
		}
		if(HMath.round512(_curr)==1 && HMath.round512(_dcurr)==0) {
			unregister();
			if(_callback!=null) _callback.run(this);
		}
	}
}
