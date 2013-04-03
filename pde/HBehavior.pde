public static abstract class HBehavior {
	public HBehavior() {
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
