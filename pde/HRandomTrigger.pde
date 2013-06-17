/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HRandomTrigger extends HTrigger {
	private float _chance;
	public HRandomTrigger() {}
	public HRandomTrigger(float percChance) {
		_chance = percChance;
	}
	public HRandomTrigger chance(float perc) {
		_chance = perc;
		return this;
	}
	public float chance() {
		return _chance;
	}
	public void runBehavior(PApplet app) {
		if(HMath.random() <= _chance) _callback.run(null);
	}
	public HRandomTrigger callback(HCallback cb) {
		return (HRandomTrigger) super.callback(cb);
	}
}
