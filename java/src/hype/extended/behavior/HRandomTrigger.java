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

import hype.core.behavior.HTrigger;
import hype.core.interfaces.HCallback;
import processing.core.PApplet;

public class HRandomTrigger extends HTrigger {
	private float _chance;
	
	public HRandomTrigger() {}
	
	public HRandomTrigger(float percChance) {
		_chance = percChance;
	}
	
	public HRandomTrigger chance(float chancePercentage) {
		_chance = chancePercentage;
		return this;
	}
	
	public float chance() {
		return _chance;
	}
	
	@Override
	public void runBehavior(PApplet app) {
		if(app.random(1) <= _chance) _callback.run(null);
	}
	
	@Override
	public HRandomTrigger callback(HCallback cb) {
		return (HRandomTrigger) super.callback(cb);
	}
}
