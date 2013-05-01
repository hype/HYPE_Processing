public static class HSwarm extends HBehavior {
	protected HLinkedHashSet<HGoal> _goals;
	protected HLinkedHashSet<HSwarmer> _targets;
	protected float _speed, _turnEase, _twitchRad, _idleGoalX, _idleGoalY;
	public HSwarm() {
		_speed = 1;
		_turnEase = 1;
		_twitchRad = 0;
		_goals = new HLinkedHashSet<HGoal>();
		_targets = new HLinkedHashSet<HSwarmer>();
	}
	public HSwarm addTarget(HSwarmer t) {
		if(_targets.size() <= 0) register();
		_targets.add(t);
		return this;
	}
	public HSwarm removeTarget(HSwarmer t) {
		_targets.remove(t);
		if(_targets.size() <= 0) unregister();
		return this;
	}
	public HLinkedHashSet<HSwarmer> targets() {
		return _targets;
	}
	public HSwarm addGoal(HGoal g) {
		_goals.add(g);
		return this;
	}
	public HSwarm addGoal(float x, float y) {
		return addGoal(new HVector(x,y));
	}
	public HSwarm removeGoal(HGoal g) {
		_goals.remove(g);
		return this;
	}
	public HLinkedHashSet<HGoal> goals() {
		return _goals;
	}
	public HSwarm idleGoal(float x, float y) {
		_idleGoalX = x;
		_idleGoalY = y;
		return this;
	}
	public float idleGoalX() {
		return _idleGoalX;
	}
	public float idleGoalY() {
		return _idleGoalY;
	}
	public HSwarm speed(float s) {
		_speed = s;
		return this;
	}
	public float speed() {
		return _speed;
	}
	public HSwarm turnEase(float e) {
		_turnEase = e;
		return this;
	}
	public float turnEase() {
		return _turnEase;
	}
	public HSwarm twitch(float deg) {
		_twitchRad = deg * HConstants.D2R;
		return this;
	}
	public HSwarm twitchRad(float rad) {
		_twitchRad = rad;
		return this;
	}
	public float twitch() {
		return _twitchRad * HConstants.R2D;
	}
	public float twitchRad() {
		return _twitchRad;
	}
	protected HGoal getGoal(HSwarmer target) {
		PApplet app = H.app();
		HGoal goal = null;
		float nearestDist = -1;
		for(HIterator<HGoal> it=_goals.iterator(); it.hasNext();) {
			HGoal h = it.next();
			float dist = app.dist(target.x(),target.y(), h.x(),h.y());
			if(nearestDist<0 || dist<nearestDist) {
				nearestDist = dist;
				goal = h;
			}
		}
		return goal;
	}
	public void runBehavior(PApplet app) {
		int numTargets = _targets.size();
		HIterator<HSwarmer> it = _targets.iterator();
		for(int i=0; i<numTargets; ++i) {
			HSwarmer target = it.next();
			float rot = target.rotationRad();
			float tx = target.x();
			float ty = target.y();
			float goalx = _idleGoalX;
			float goaly = _idleGoalY;
			HGoal goal = getGoal(target);
			if(goal != null) {
				goalx = goal.x();
				goaly = goal.y();
			}
			float tmp = HMath.xAxisAngle(tx,ty, goalx,goaly) - rot;
			float dRot = app.atan2(app.sin(tmp),app.cos(tmp)) * _turnEase;
			rot += dRot;
			float noise = app.noise(i*numTargets + app.frameCount/8f);
			rot += app.map(noise, 0,1, -_twitchRad,_twitchRad);
			target.rotationRad(rot);
			target.move(app.cos(rot)*_speed, app.sin(rot)*_speed);
		}
	}
	public HSwarm register() {
		return (HSwarm) super.register();
	}
	public HSwarm unregister() {
		return (HSwarm) super.unregister();
	}
}
