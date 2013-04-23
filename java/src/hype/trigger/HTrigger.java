package hype.trigger;

import hype.behavior.HBehavior;
import hype.interfaces.HCallback;

public abstract class HTrigger extends HBehavior {
	public HCallback _callback;
	
	public HTrigger callback(HCallback cb) {
		if(cb == null) unregister();
		else register();
		
		_callback = cb;
		return this;
	}
	
	public HCallback callback() {
		return _callback;
	}
}
