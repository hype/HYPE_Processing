package hype.behavior;

import hype.util.H;

public abstract class HBehavior {
	public HBehavior() {
		// Register this by default
		H.addBehavior(this);
	}
	
	public HBehavior register() {
		H.addBehavior(this);
		return this;
	}
	
	public HBehavior unregister() {
		H.removeBehavior(this);
		return this;
	}
	
	public abstract void runBehavior();
}
