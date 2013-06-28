class CheckEdges extends HBehavior {
	private HLocatable _target;

	public CheckEdges target(HLocatable t) {
		if(t == null) unregister();
		else register();
		_target = t;
		return this;
	}
	public HLocatable target() {
		return _target;
	}

	public void runBehavior(PApplet app) {
		if (_target.x() > width) {
		  _target.x(0);
		} else if (_target.x() < 0) {
		  _target.x(width);
		}
		if (_target.y() > height) {
			_target.y(0);
		} else if (_target.y() < 0) {
		  _target.y(height);
		}
	}

	public CheckEdges register() {
		return (CheckEdges) super.register();
	}
	public CheckEdges unregister() {
		return (CheckEdges) super.unregister();
	}
}