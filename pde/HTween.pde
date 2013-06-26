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
public static class HTween extends HBehavior {
	private HDrawable _target;
	private HCallback _callback;
	private float _s1, _s2, _s3;
	private float _e1, _e2, _e3;
	private float _curr1, _curr2, _curr3;
	private float _origw, _origh;
	private float _raw, _dRaw, _spring, _ease;
	private int _property;
	public HTween() {
		_ease = 1;
		_callback = HConstants.NOP;
		register();
	}
	public HTween target(HDrawable d) {
		_target = d;
		if(d != null) {
			_origw = d.width();
			_origh = d.height();
		}
		return this;
	}
	public HDrawable target() {
		return _target;
	}
	public HTween callback(HCallback c) {
		_callback = (c==null)? HConstants.NOP : c;
		return this;
	}
	public HCallback callback() {
		return _callback;
	}
	public HTween start(float a) {
		return start(a,a);
	}
	public HTween start(float a, float b) {
		return start(a,b,0);
	}
	public HTween start(float a, float b, float c) {
		_s1 = a;
		_s2 = b;
		_s3 = c;
		return this;
	}
	public float start() {
		return _s1;
	}
	public float start1() {
		return _s1;
	}
	public float start2() {
		return _s2;
	}
	public float start3() {
		return _s3;
	}
	public HTween end(float a) {
		return end(a,a);
	}
	public HTween end(float a, float b) {
		return end(a,b,0);
	}
	public HTween end(float a, float b, float c) {
		_e1 = a;
		_e2 = b;
		_e3 = c;
		return this;
	}
	public float end() {
		return _e1;
	}
	public float end1() {
		return _e1;
	}
	public float end2() {
		return _e2;
	}
	public float end3() {
		return _e3;
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
	public float nextRaw() {
		_raw += (_dRaw) = (_dRaw*_spring + (1-_raw)*_ease);
		float c = HMath.round512(_raw);
		_curr1 = HMath.map(c,0,1,_s1,_e1);
		_curr2 = HMath.map(c,0,1,_s2,_e2);
		_curr3 = HMath.map(c,0,1,_s3,_e3);
		return c;
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
		float c = nextRaw();
		float v1 = _curr1;
		float v2 = _curr2;
		float v3 = _curr3;
		switch(_property) {
		case HConstants.WIDTH:		_target.width(v1); break;
		case HConstants.HEIGHT:		_target.height(v1); break;
		case HConstants.SCALE:
			v1 *= _origw;
			v2 *= _origh;
		case HConstants.SIZE:		_target.size(v1,v2); break;
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
		if(c==1 && HMath.round512(_dRaw)==0) {
			unregister();
			_callback.run(this);
		}
	}
	public HTween register() {
		return (HTween) super.register();
	}
	public HTween unregister() {
		_raw = _dRaw = 0;
		return (HTween) super.unregister();
	}
}
