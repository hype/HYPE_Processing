package hype.behavior;

import hype.drawable.HDrawable;
import hype.util.H;
import hype.util.HFollowable;
import hype.util.HFollower;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PVector;

@SuppressWarnings("static-access")
public class HSwarm extends HBehavior implements HFollower, HFollowable {
	protected float _goalX, _goalY, _speed, _turnEase, _twitch;
	protected ArrayList<HDrawable> _swarmers;
	
	public HSwarm() {
		_speed = 1;
		_turnEase = 1;
		_twitch = 16;
		_swarmers = new ArrayList<HDrawable>();
		
		H.addBehavior(this);
	}
	
	public HSwarm addTarget(HDrawable swarmer) {
		_swarmers.add(swarmer);
		return this;
	}
	
	public HDrawable target(int i) {
		return _swarmers.get(i);
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
		_twitch = deg * H.D2R;
		return this;
	}
	
	public HSwarm twitchRad(float rad) {
		_twitch = rad;
		return this;
	}
	
	public float twitch() {
		return _twitch * H.R2D;
	}
	
	public float twitchRad() {
		return _twitch;
	}

	@Override
	public float followerX() {
		return _goalX;
	}

	@Override
	public float followerY() {
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
	public void follow(float dx, float dy) {
		_goalX += dx;
		_goalY += dy;
	}

	@Override
	public void runBehavior() {
		PApplet app = H.app();
		
		int numSwarmers = _swarmers.size();
		for(int i=0; i<numSwarmers; ++i) {
			HDrawable swarmer = _swarmers.get(i);
			
			float rot = swarmer.rotationRad();
			float tx = swarmer.x();
			float ty = swarmer.y();
			
			// Get rotation that points towards the goal, plus easing
			float tmp = H.xAxisAngle(tx,ty, _goalX,_goalY) - rot;
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
