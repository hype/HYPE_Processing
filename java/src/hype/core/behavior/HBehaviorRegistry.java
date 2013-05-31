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

package hype.core.behavior;

import processing.core.PApplet;

public class HBehaviorRegistry {
	private HBehaviorSentinel _firstSentinel;

	public HBehaviorRegistry() {
		_firstSentinel = new HBehaviorSentinel(this);
	}

	public boolean isRegistered(HBehavior b) {
		return (b._registry != null && b._registry.equals(this));
	}

	public void register(HBehavior b) {
		if(b.poppedOut()) b.putAfter(_firstSentinel);
	}

	public void unregister(HBehavior b) {
		if(isRegistered(b)) b.popOut();
	}

	public void runAll(PApplet app) {
		HBehavior n = _firstSentinel.next();
		while(n != null) {
			n.runBehavior(app);
			n = n.next();
		}
	}



	public static class HBehaviorSentinel extends HBehavior {
		public HBehaviorSentinel(HBehaviorRegistry r) {
			_registry = r;
		}

		@Override
		public void runBehavior(PApplet app) {}
	}
}