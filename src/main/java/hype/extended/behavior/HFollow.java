package hype.extended.behavior;

import hype.H;
import hype.HBehavior;
import hype.interfaces.HLocatable;
import hype.HMouse;
import processing.core.PApplet;

public class HFollow extends HBehavior {
	private float ease, spring, dx, dy, dz;
	private HLocatable goal;
	private HLocatable follower;

	private boolean usesMouse;

	public HFollow() {
		this(1);
	}

	public HFollow(float ease) {
		this(ease,0);
	}

	public HFollow(float ease, float spring) {
		this(ease, spring, H.mouse());
	}

	public HFollow(float ease, float spring, HLocatable goal) {
		this.ease = ease;
		this.spring = spring;
		this.goal = goal;

		this.usesMouse = true;
	}

	public HFollow ease(float f) {
		ease = f;
		return this;
	}

	public float ease() {
		return ease;
	}

	public HFollow spring(float f) {
		spring = f;
		return this;
	}

	public float spring() {
		return spring;
	}

	public HFollow goal(HLocatable g) {
		goal = g;

		usesMouse = false;
		if (g instanceof HMouse) {
			usesMouse = true;
		}

		return this;
	}

	public HLocatable goal() {
		return goal;
	}

	public HFollow followMouse() {
		goal = H.mouse();
		return this;
	}

	public HFollow target(HLocatable f) {
		if(f == null) unregister();
		else register();

		follower = f;
		return this;
	}

	public HLocatable target() {
		return follower;
	}

	@Override
	public void runBehavior(PApplet app) {
		if(follower==null || (usesMouse == true && ! H.mouse().started())) return;

		dx = dx*spring + (goal.x()-follower.x()) * ease;
		dy = dy*spring + (goal.y()-follower.y()) * ease;
		dz = dz*spring + (goal.z()-follower.z()) * ease;

		follower.x(follower.x() + dx);
		follower.y(follower.y() + dy);
		follower.z(follower.z() + dz);
	}

	@Override
	public HFollow register() {
		return (HFollow) super.register();
	}

	@Override
	public HFollow unregister() {
		return (HFollow) super.unregister();
	}
}
