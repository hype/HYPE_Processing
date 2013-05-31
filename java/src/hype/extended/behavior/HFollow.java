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
import hype.core.interfaces.HLocatable;
import hype.core.util.H;
import processing.core.PApplet;

public class HFollow extends HBehavior {
	private float _ease, _spring, _dx, _dy;
	private HLocatable _goal;
	private HLocatable _follower;
	
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
	
	public HFollow goal(HLocatable g) {
		_goal = g;
		return this;
	}
	
	public HLocatable goal() {
		return _goal;
	}
	
	public HFollow followMouse() {
		_goal = H.mouse();
		return this;
	}
	
	public HFollow target(HLocatable f) {
		if(f == null) unregister();
		else register();
		
		_follower = f;
		return this;
	}
	
	public HLocatable target() {
		return _follower;
	}
	
	@Override
	public void runBehavior(PApplet app) {
		if(_follower==null || ! H.mouse().started()) return;
		
		_dx = _dx*_spring + (_goal.x()-_follower.x()) * _ease;
		_dy = _dy*_spring + (_goal.y()-_follower.y()) * _ease;
		
		_follower.x(_follower.x() + _dx);
		_follower.y(_follower.y() + _dy);
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
