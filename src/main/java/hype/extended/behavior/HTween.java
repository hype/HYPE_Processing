package hype.extended.behavior;

import hype.HBehavior;
import hype.HDrawable;
import hype.HCallback;
import hype.interfaces.HConstants;
import hype.HMath;
import processing.core.PApplet;

public class HTween extends HBehavior {
	private HDrawable target;
	private HCallback callback;
	private float s1, s2, s3;
	private float e1, e2, e3;
	private float curr1, curr2, curr3;
	private float origw, origh;
	private float raw, dRaw, spring, ease;
	private int property;

	public HTween() {
		ease = 1;
		callback = HConstants.NOP;
		register();
	}

	public HTween target(HDrawable d) {
		target = d;
		if(d != null) {
			origw = d.width();
			origh = d.height();
		}
		return this;
	}

	public HDrawable target() {
		return target;
	}

	public HTween callback(HCallback c) {
		callback = (c==null)? HConstants.NOP : c;
		return this;
	}

	public HCallback callback() {
		return callback;
	}

	public HTween start(float a) {
		return start(a,a);
	}

	public HTween start(float a, float b) {
		return start(a,b,0);
	}

	public HTween start(float a, float b, float c) {
		s1 = a;
		s2 = b;
		s3 = c;
		return this;
	}

	public float start() {
		return s1;
	}

	public float start1() {
		return s1;
	}

	public float start2() {
		return s2;
	}

	public float start3() {
		return s3;
	}

	public HTween end(float a) {
		return end(a,a);
	}

	public HTween end(float a, float b) {
		return end(a,b,0);
	}

	public HTween end(float a, float b, float c) {
		e1 = a;
		e2 = b;
		e3 = c;
		return this;
	}

	public float end() {
		return e1;
	}

	public float end1() {
		return e1;
	}

	public float end2() {
		return e2;
	}

	public float end3() {
		return e3;
	}

	public HTween spring(float f) {
		spring = f;
		return this;
	}

	public float spring() {
		return spring;
	}

	public HTween ease(float f) {
		ease = f;
		return this;
	}

	public float ease() {
		return ease;
	}

	public HTween property(int id) {
		property = id;
		return this;
	}

	public int property() {
		return property;
	}

	public float nextRaw() {
		raw += (dRaw) = (dRaw * spring + (1- raw)* ease);
		float c = HMath.round512(raw);
		curr1 = HMath.map(c,0,1, s1, e1);
		curr2 = HMath.map(c,0,1, s2, e2);
		curr3 = HMath.map(c,0,1, s3, e3);
		return c;
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

	@Override
	public void runBehavior(PApplet app) {
		if(target ==null) return;

		float c = nextRaw();
		float v1 = curr1;
		float v2 = curr2;
		float v3 = curr3;

		switch(property) {
		case HConstants.WIDTH:		target.width(v1); break;
		case HConstants.HEIGHT:		target.height(v1); break;
		case HConstants.SCALE:
			v1 *= origw;
			v2 *= origh;
		case HConstants.SIZE:		target.size(v1, v2); break;
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
		if(c==1 && HMath.round512(dRaw)==0) {
			unregister();
			callback.run(this);
		}
	}

	@Override
	public HTween register() {
		return (HTween) super.register();
	}

	@Override
	public HTween unregister() {
		raw = dRaw = 0;
		return (HTween) super.unregister();
	}
}
