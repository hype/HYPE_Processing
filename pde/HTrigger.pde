public static abstract class HTrigger extends HBehavior {
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
