/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.extended.behavior;

import hype.core.behavior.HBehavior;
import hype.core.collection.HLinkedHashSet;
import hype.core.interfaces.HDirectable;
import hype.core.interfaces.HLocatable;
import hype.core.util.HConstants;
import hype.core.util.HMath;
import hype.core.util.HVector;

import java.util.Iterator;

import processing.core.PApplet;

public class HSwarm extends HBehavior {
	private HLinkedHashSet<HLocatable> _goals;
	private HLinkedHashSet<HDirectable> _targets;
	private float _speed, _turnEase, _twitchRad, _idleGoalX, _idleGoalY;
	
	public HSwarm() {
		_speed = 1;
		_turnEase = 1;
		_twitchRad = 0;
		_goals = new HLinkedHashSet<HLocatable>();
		_targets = new HLinkedHashSet<HDirectable>();
	}
	
	public HSwarm addTarget(HDirectable t) {
		if(_targets.size() <= 0) register();
		_targets.add(t);
		return this;
	}
	
	public HSwarm removeTarget(HDirectable t) {
		_targets.remove(t);
		if(_targets.size() <= 0) unregister();
		return this;
	}
	
	public HLinkedHashSet<HDirectable> targets() {
		return _targets;
	}
	
	public HSwarm addGoal(HLocatable g) {
		_goals.add(g);
		return this;
	}
	
	public HSwarm addGoal(float x, float y) {
		return addGoal(new HVector(x,y));
	}
	
	public HSwarm addGoal(float x, float y, float z) {
		return addGoal(new HVector(x,y,z));
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
	
	private HLocatable getGoal(HDirectable target, PApplet app) {
		HLocatable goal = null;
		float nearestDist = -1;
		
		for(HLocatable h : _goals) {
			float dist = HMath.dist(target.x(),target.y(), h.x(),h.y());
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
		Iterator<HDirectable> it = _targets.iterator();
		for(int i=0; i<numTargets; ++i) {
			HDirectable target = it.next();
			
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
			rot += HMath.map(noise, 0,1, -_twitchRad,_twitchRad);
			
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
