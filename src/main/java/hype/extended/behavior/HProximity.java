package hype.extended.behavior;

import hype.HDrawable3D;
import hype.HBehavior;
import hype.HDrawable;
import hype.interfaces.HConstants;
import processing.core.PApplet;
import processing.core.PVector;


public class HProximity extends HBehavior {

	private HDrawable target, neighbor;
	private int property;
	private float min, max, range, radius, rSq, dist, spring, ease, goal, speed, value;
	private float origw, origh, origd;
	private boolean useMouse;

	public HProximity () {
		property = HConstants.ALPHA;
		radius = 100;
		rSq = radius * radius;
		spring = (float) 0.9;
		ease = (float) 0.3;
		min = 50;
		max = 255;
		range = (max - min);
		value = min;
		speed = 0;
		goal = max;
		useMouse = true;
		neighbor = null;

		register();
	}

	public HProximity (float spring, float ease, float min, float max, float radius) {
		property = HConstants.ALPHA;
		this.radius = radius;
		rSq = this.radius * this.radius;
		this.spring = spring;
		this.ease = ease;
		this.min = min;
		this.max = max;
		range = (this.max - this.min);
		value = this.min;
		speed = 0;
		goal = 0;
		useMouse = true;
		neighbor = null;

		register();
	}

	public HProximity target(HDrawable d) {
		target = d;
		if(d != null) {
			origw = d.width();
			origh = d.height();
			origd = 0;
		}
		return this;
	}

	public HProximity target(HDrawable3D d) {
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

	public HProximity property(int id) {
		property = id;
		return this;
	}

	public int property() {
		return property;
	}

	public HProximity neighbor(HDrawable d) {
		useMouse = false;
		neighbor = d;
		return this;
	}

	public HDrawable neighbor() {
		return neighbor;
	}

	public HProximity min(float f) {
		min = f;
		value = f;
		range = (max - min);
		return this;
	}
	public float min() {
		return min;
	}

	public HProximity max(float f) {
		max = f;
		goal = f;
		range = (max - min);
		return this;
	}
	public float max() {
		return max;
	}

	public HProximity radius(float f) {
		radius = f;
		rSq = radius * radius;
		return this;
	}
	public float radius() {
		return radius;
	}

	public HProximity spring(float f) {
		spring = f;
		return this;
	}
	public float spring() {
		return spring;
	}

	public HProximity ease(float f) {
		ease = f;
		return this;
	}
	public float ease() {
		return ease;
	}

	private void run(float x, float y) {
		dist = ((target.x() - x) * (target.x() - x)) + ((target.y() - y) * (target.y() - y));

		if (dist < rSq) {
			goal = (1 - (dist / rSq)) * range + min;
		} else {
			goal = min;
		}

		speed = (speed * spring) + ((goal - value) * ease);
		value += speed;
	}

	@Override
	public void runBehavior(PApplet app) {
		if(target ==null) return;

		if (useMouse == true) {
			run(app.mouseX, app.mouseY);
		} else {
			run(neighbor.x(), neighbor.y());
		}

		float v1 = value;
		float v2 = value;
		float v3 = value;

		switch(property) {
			case HConstants.WIDTH:		target.width(value); break;
			case HConstants.HEIGHT:		target.height(value); break;
			case HConstants.SCALE:
				v1 *= origw;
				v2 *= origh;
				v3 *= origd;
			case HConstants.SIZE: 		target.size(new PVector(v1, v2, v3)); break;
			case HConstants.ALPHA:		target.alpha(Math.round(value)); break;
			case HConstants.ROTATIONX:	target.rotationX(value); break;
			case HConstants.ROTATIONY:	target.rotationY(value); break;
			case HConstants.ROTATIONZ:	target.rotationZ(value); break;
			case HConstants.DROTATIONX:	target.rotateX(value); break;
			case HConstants.DROTATIONY:	target.rotateY(value); break;
			case HConstants.DROTATIONZ:	target.rotateZ(value); break;
			default: break;
		}
	}

	@Override
	public HProximity register() {
		return (HProximity) super.register();
	}

	@Override
	public HProximity unregister() {
		return (HProximity) super.unregister();
	}
}
