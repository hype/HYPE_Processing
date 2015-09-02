package hype;

import hype.interfaces.HConstants;

public abstract class HTrigger extends HBehavior {
	protected HCallback callback;

	public HTrigger() {
		register();
		callback = HConstants.NOP;
	}

	public HTrigger callback(HCallback cb) {
		callback = (cb==null)? HConstants.NOP : cb;
		return this;
	}

	public HCallback callback() {
		return callback;
	}
}
