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
public static abstract class HBehavior extends HNode<HBehavior> {
	protected HBehaviorRegistry _registry;
	public HBehavior register() {
		H.behaviors().register(this);
		return this;
	}
	public HBehavior unregister() {
		H.behaviors().unregister(this);
		return this;
	}
	public boolean poppedOut() {
		return _registry == null;
	}
	public void popOut() {
		super.popOut();
		_registry = null;
	}
	public void swapLeft() {
		if(_prev._prev == null) return;
		super.swapLeft();
	}
	public void putAfter(HBehavior dest) {
		if(dest._registry == null) return;
		super.putAfter(dest);
		_registry = dest._registry;
	}
	public void putBefore(HBehavior dest) {
		if(dest._registry == null) return;
		super.putBefore(dest);
		_registry = dest._registry;
	}
	public void replaceNode(HBehavior target) {
		super.replaceNode(target);
		_registry = target._registry;
		target._registry = null;
	}
	public abstract void runBehavior(PApplet app);
}
