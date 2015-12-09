package hype.extended.behavior;

import hype.HBehavior;
import hype.HMath;
import hype.HVector;
import hype.HLinkedHashSet;
import hype.interfaces.HDirectable;
import hype.interfaces.HLocatable;
import hype.interfaces.HConstants;

import java.util.Iterator;

import processing.core.PApplet;

public class HSwarm extends HBehavior {
	private HLinkedHashSet<HLocatable> goals;
	private HLinkedHashSet<HDirectable> targets;
	private float speed, turnEase, twitchRad, idleGoalX, idleGoalY;

	public HSwarm() {
		speed = 1;
		turnEase = 1;
		twitchRad = 0;
		goals = new HLinkedHashSet<HLocatable>();
		targets = new HLinkedHashSet<HDirectable>();
	}

	public HSwarm addTarget(HDirectable t) {
		if(targets.size() <= 0) register();
		targets.add(t);
		return this;
	}

	public HSwarm removeTarget(HDirectable t) {
		targets.remove(t);
		if(targets.size() <= 0) unregister();
		return this;
	}

	public HLinkedHashSet<HDirectable> targets() {
		return targets;
	}

	public HSwarm addGoal(HLocatable g) {
		goals.add(g);
		return this;
	}

	public HSwarm addGoal(float x, float y) {
		return addGoal(new HVector(x,y));
	}

	public HSwarm addGoal(float x, float y, float z) {
		return addGoal(new HVector(x,y,z));
	}

	public HSwarm removeGoal(HLocatable g) {
		goals.remove(g);
		return this;
	}

	public HLinkedHashSet<HLocatable> goals() {
		return goals;
	}

	public HSwarm idleGoal(float x, float y) {
		idleGoalX = x;
		idleGoalY = y;
		return this;
	}

	public float idleGoalX() {
		return idleGoalX;
	}

	public float idleGoalY() {
		return idleGoalY;
	}

	public HSwarm speed(float s) {
		speed = s;
		return this;
	}

	public float speed() {
		return speed;
	}

	public HSwarm turnEase(float e) {
		turnEase = e;
		return this;
	}

	public float turnEase() {
		return turnEase;
	}

	public HSwarm twitch(float deg) {
		twitchRad = deg * HConstants.D2R;
		return this;
	}

	public HSwarm twitchRad(float rad) {
		twitchRad = rad;
		return this;
	}

	public float twitch() {
		return twitchRad * HConstants.R2D;
	}

	public float twitchRad() {
		return twitchRad;
	}

	private HLocatable getGoal(HDirectable target, PApplet app) {
		HLocatable goal = null;
		float nearestDist = -1;

		for(HLocatable h : goals) {
			float dist = HMath.dist(target.x(), target.y(), h.x(), h.y());
			if(nearestDist<0 || dist<nearestDist) {
				nearestDist = dist;
				goal = h;
			}
		}
		return goal;
	}

	@Override
	public void runBehavior(PApplet app) {
		int numTargets = targets.size();
		Iterator<HDirectable> it = targets.iterator();
		for(int i=0; i<numTargets; ++i) {
			HDirectable target = it.next();

			float rot = target.rotationRad();
			float tx = target.x();
			float ty = target.y();

			float goalx = idleGoalX;
			float goaly = idleGoalY;
			float goalz = 0;
			HLocatable goal = getGoal(target, app);
			if(goal != null) {
				goalx = goal.x();
				goaly = goal.y();
				goalz = goal.z();
			}

			// Get rotation that points towards the goal, plus easing
			float tmp = HMath.xAxisAngle(tx,ty, goalx,goaly) - rot;
			float dRot = turnEase * (float)
				Math.atan2( Math.sin(tmp), Math.cos(tmp) );
			rot += dRot;

			// Add some random twitching to the rotation via perlin noise
			float noise = app.noise(i*numTargets + app.frameCount/8f);
			rot += HMath.map(noise, 0,1, -twitchRad, twitchRad);

			// Apply the rotation and move to the direction of its rotation
			target.rotationRad(rot);
			target.x(target.x() + (float)Math.cos(rot)* speed);
			target.y(target.y() + (float)Math.sin(rot)* speed);
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
