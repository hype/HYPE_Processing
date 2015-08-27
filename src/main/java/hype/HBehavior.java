package hype;

import processing.core.PApplet;

public abstract class HBehavior extends HNode<HBehavior> {
	protected HBehaviorRegistry registry;

	/**
	 * Registers behavior with HBehaviorRegistry
	 * @param hype
	 * @return
	 */
	public HBehavior register() {
		H.behaviors().register(this);
		return this;
	}

	public HBehavior unregister() {
		H.behaviors().unregister(this);
		return this;
	}

	@Override
	public boolean poppedOut() {
		return registry == null;
	}

	@Override
	public void popOut() {
		super.popOut();
		registry = null;
	}

	@Override
	public void swapLeft() {
		if(prev.prev == null) return;
		super.swapLeft();
	}

	@Override
	public void putAfter(HBehavior dest) {
		if(dest.registry == null) return;

		super.putAfter(dest);
		registry = dest.registry;
	}

	@Override
	public void putBefore(HBehavior dest) {
		if(dest.registry == null) return;

		super.putBefore(dest);
		registry = dest.registry;
	}

	@Override
	public void replaceNode(HBehavior target) {
		super.replaceNode(target);
		registry = target.registry;
		target.registry = null;
	}

	public abstract void runBehavior(PApplet app);
}
