package hype.behavior;

import hype.collection.HIterator;
import hype.collection.HLinkedHashSet;
import hype.interfaces.HFollowable;
import hype.interfaces.HMovable;
import hype.interfaces.HSwarmer;
import hype.util.HConstants;
import hype.util.HMath;
import processing.core.PApplet;
import processing.core.PVector;

@SuppressWarnings("static-access")
public class HSwarm extends HBehavior implements HMovable, HFollowable {
	protected float _goalX, _goalY, _speed, _turnEase, _twitch;
	protected HLinkedHashSet<HSwarmer> _swarmers;
	
	public HSwarm() {
		_speed = 1;
		_turnEase = 1;
		_twitch = 16;
		_swarmers = new HLinkedHashSet<HSwarmer>();
	}
	
	public HSwarm addTarget(HSwarmer d) {
		if(_swarmers.size() <= 0) register();
		_swarmers.add(d);
		return this;
	}
	
	public HSwarm removeTarget(HSwarmer d) {
		_swarmers.remove(d);
		if(_swarmers.size() <= 0) unregister();
		return this;
	}
	
	public HSwarm goal(float x, float y) {
		_goalX = x;
		_goalY = y;
		return this;
	}
	
	public PVector goal() {
		return new PVector(_goalX,_goalY);
	}
	
	public HSwarm goalX(float x) {
		_goalX = x;
		return this;
	}
	
	public float goalX() {
		return _goalX;
	}
	
	public HSwarm goalY(float y) {
		_goalY = y;
		return this;
	}
	
	public float goalY() {
		return _goalY;
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
		_twitch = deg * HConstants.D2R;
		return this;
	}
	
	public HSwarm twitchRad(float rad) {
		_twitch = rad;
		return this;
	}
	
	public float twitch() {
		return _twitch * HConstants.R2D;
	}
	
	public float twitchRad() {
		return _twitch;
	}

	@Override
	public float x() {
		return _goalX;
	}

	@Override
	public float y() {
		return _goalY;
	}
	
	@Override
	public float followableX() {
		return _goalX;
	}

	@Override
	public float followableY() {
		return _goalY;
	}
	
	@Override
	public HSwarm move(float dx, float dy) {
		_goalX += dx;
		_goalY += dy;
		return this;
	}

	@Override
	public void runBehavior(PApplet app) {
		int numSwarmers = _swarmers.size();
		HIterator<HSwarmer> it = _swarmers.iterator();
		for(int i=0; i<numSwarmers; ++i) {
			HSwarmer swarmer = it.next();
			
			float rot = swarmer.rotationRad();
			float tx = swarmer.x();
			float ty = swarmer.y();
			
			// Get rotation that points towards the goal, plus easing
			float tmp = HMath.xAxisAngle(tx,ty, _goalX,_goalY) - rot;
			float dRot = app.atan2(app.sin(tmp),app.cos(tmp)) * _turnEase;
			rot += dRot;
			
			// Add some random twitching to the rotation via perlin noise
			float noise = app.noise(i*numSwarmers + app.frameCount/8f);
			rot += app.map(noise, 0,1, -_twitch,_twitch);
			
			// Apply the rotation and move to the direction of its rotation
			swarmer.rotationRad(rot);
			swarmer.move(app.cos(rot)*_speed, app.sin(rot)*_speed);
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
