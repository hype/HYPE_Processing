public static class HFollow extends HBehavior {
	protected float _ease, _spring, _dx, _dy;
	protected HFollowable _goal;
	protected HMovable _follower;
	public HFollow() {
		this(1);
	}
	public HFollow(float ease) {
		this(ease,0);
	}
	public HFollow(float ease, float spring) {
		this(ease, spring, H.mouse());
	}
	public HFollow(float ease, float spring, HFollowable goal) {
		_ease = ease;
		_spring = spring;
		_goal = goal;
	}
	public HFollow ease(float f) {
		_ease = f;
		return this;
	}
	public float ease() {
		return _ease;
	}
	public HFollow spring(float f) {
		_spring = f;
		return this;
	}
	public float spring() {
		return _spring;
	}
	public HFollow goal(HFollowable g) {
		_goal = g;
		return this;
	}
	public HFollowable goal() {
		return _goal;
	}
	public HFollow followMouse() {
		_goal = H.mouse();
		return this;
	}
	public HFollow target(HMovable f) {
		if(f == null) unregister();
		else register();
		_follower = f;
		return this;
	}
	public HMovable target() {
		return _follower;
	}
	public void runBehavior(PApplet app) {
		if(_follower==null || ! H.mouse().started()) return;
		_dx = _dx*_spring +
			(_goal.followableX()-_follower.x()) * _ease;
		_dy = _dy*_spring +
			(_goal.followableY()-_follower.y()) * _ease;
		_follower.move(_dx,_dy);
	}
	public HFollow register() {
		return (HFollow) super.register();
	}
	public HFollow unregister() {
		return (HFollow) super.unregister();
	}
}
