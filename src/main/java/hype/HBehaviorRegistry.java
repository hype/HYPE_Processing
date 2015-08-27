package hype;

import processing.core.PApplet;

public class HBehaviorRegistry {
	private HBehaviorSentinel firstSentinel;

	public HBehaviorRegistry() {
		firstSentinel = new HBehaviorSentinel(this);
	}

	public boolean isRegistered(HBehavior b) {
		return (b.registry != null && b.registry.equals(this));
	}

	public void register(HBehavior b) {
		if(b.poppedOut()) b.putAfter(firstSentinel);
	}

	public void unregister(HBehavior b) {
		if(isRegistered(b)) b.popOut();
	}

	public void runAll(PApplet app) {
		HBehavior n = firstSentinel.next();
		while(n != null) {
			n.runBehavior(app);
			n = n.next();
		}
	}

	public static class HBehaviorSentinel extends HBehavior {
		public HBehaviorSentinel(HBehaviorRegistry r) {
			registry = r;
		}

		@Override
		public void runBehavior(PApplet app) {}
	}
}