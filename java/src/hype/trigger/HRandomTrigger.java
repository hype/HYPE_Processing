package hype.trigger;

import hype.interfaces.HCallback;
import hype.util.HMath;
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
		if(HMath.random() <= _chance) {
			if(_callback != null) _callback.run(null);
		}
	}
	
	@Override
	public HRandomTrigger callback(HCallback cb) {
		return (HRandomTrigger) super.callback(cb);
	}
}
