package hype.trigger;

import hype.interfaces.HCallback;
import processing.core.PApplet;

public class HRandomTrigger extends HTrigger {
	public float _chance;
	
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
	
	@Override
	public void runBehavior(PApplet app) {
		if(app.random(1) <= _chance) {
			if(_callback != null) _callback.run(null);
		}
	}
	
	@Override
	public HRandomTrigger callback(HCallback cb) {
		return (HRandomTrigger) super.callback(cb);
	}
}
