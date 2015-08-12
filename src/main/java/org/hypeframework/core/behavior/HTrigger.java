package org.hypeframework.core.behavior;

import org.hypeframework.core.interfaces.HCallback;
import org.hypeframework.core.util.HConstants;

public abstract class HTrigger extends HBehavior {
	protected HCallback _callback;

	public HTrigger() {
		register();
		_callback = HConstants.NOP;
	}

	public HTrigger callback(HCallback cb) {
		_callback = (cb==null)? HConstants.NOP : cb;
		return this;
	}

	public HCallback callback() {
		return _callback;
	}
}
