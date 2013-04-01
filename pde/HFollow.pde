

public static class HFollow extends HBehavior {
	protected float _ease, _spring, _dx, _dy;
	protected HFollowable _goal;
	protected HFollower _follower;
	
	public HFollow() {
		this(1);
	}
	
	public HFollow(float ease) {
		this(ease,0);
	}
	
	public HFollow(float ease, float spring) {
		this(ease, spring, H.stage());
	}
	
	public HFollow(float ease, float spring, HFollowable goal) {
		_ease = ease;
		_spring = spring;
		_goal = goal;
		
		H.addBehavior(this);
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
		_goal = H.stage();
		return this;
	}
	
	public HFollow target(HFollower f) {
		_follower = f;
		return this;
	}
	
	public HFollower target() {
		return _follower;
	}
	
	public void runBehavior() {
		if(_follower==null || ! H.stage().mouseStarted()) return;
		
		_dx = _dx*_spring +
			(_goal.followableX()-_follower.followerX()) * _ease;
		
		_dy = _dy*_spring +
			(_goal.followableY()-_follower.followerY()) * _ease;
		
		_follower.follow(_dx,_dy);
	}
	
	public HFollow register() {
		return (HFollow) super.register();
	}
	
	public HFollow unregister() {
		return (HFollow) super.unregister();
	}
}
