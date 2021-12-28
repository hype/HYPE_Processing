package hype.extended.behavior;

import hype.HTrigger;
import hype.HCallback;
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
		if(app.random(1) <= _chance) callback.run(null);
	}

	@Override
	public HRandomTrigger callback(HCallback cb) {
		return (HRandomTrigger) super.callback(cb);
	}
}
