package hype.behavior;

import hype.collection.HIterator;
import hype.collection.HLinkedHashSet;
import hype.interfaces.HLocatable;
import hype.interfaces.HSwarmer;
import hype.util.HConstants;
import hype.util.HMath;
import hype.util.HVector;
import processing.core.PApplet;

@SuppressWarnings("static-access")
public class HSwarm extends HBehavior {
	protected HLinkedHashSet<HLocatable> _goals;
	protected HLinkedHashSet<HSwarmer> _targets;
	protected float _speed, _turnEase, _twitchRad, _idleGoalX, _idleGoalY;
	
	public HSwarm() {
		_speed = 1;
		_turnEase = 1;
		_twitchRad = 0;
		_goals = new HLinkedHashSet<HLocatable>();
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
	
	public HSwarm addGoal(HLocatable g) {
		_goals.add(g);
		return this;
	}
	
	public HSwarm addGoal(float x, float y) {
		return addGoal(new HVector(x,y));
	}
	
	public HSwarm removeGoal(HLocatable g) {
		_goals.remove(g);
		return this;
	}
	
	public HLinkedHashSet<HLocatable> goals() {
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
	
	protected HLocatable getGoal(HSwarmer target, PApplet app) {
		HLocatable goal = null;
		float nearestDist = -1;
		
		for(HIterator<HLocatable> it=_goals.iterator(); it.hasNext();) {
			HLocatable h = it.next();
			float dist = app.dist(target.x(),target.y(), h.x(),h.y());
			if(nearestDist<0 || dist<nearestDist) {
				nearestDist = dist;
				goal = h;
			}
		}
		return goal;
	}

	@Override
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
			float goalz = 0;
			HLocatable goal = getGoal(target, app);
			if(goal != null) {
				goalx = goal.x();
				goaly = goal.y();
				goalz = goal.z();
			}
			
			// Get rotation that points towards the goal, plus easing
			float tmp = HMath.xAxisAngle(tx,ty, goalx,goaly) - rot;
			float dRot = _turnEase * (float)
				Math.atan2( Math.sin(tmp), Math.cos(tmp) );
			rot += dRot;
			
			// Add some random twitching to the rotation via perlin noise
			float noise = app.noise(i*numTargets + app.frameCount/8f);
			rot += app.map(noise, 0,1, -_twitchRad,_twitchRad);
			
			// Apply the rotation and move to the direction of its rotation
			target.rotationRad(rot);
			target.x(target.x() + (float)Math.cos(rot)*_speed);
			target.y(target.y() + (float)Math.sin(rot)*_speed);
			target.z(goalz);
		}
	}
	
	@Override
	public HSwarm register() {
		return (HSwarm) super.register();
	}
	
	@Override
	public HSwarm unregister() {
		return (HSwarm) super.unregister();
	}
}
