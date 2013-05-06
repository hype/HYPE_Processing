public static class HMouse implements HLocatable {
	private PApplet _app;
	private int _button;
	private boolean _started, _moved, _clicked, _dragged;
	public HMouse(PApplet app) {
		_app = app;
	}
	public boolean started() {
		return _started;
	}
	public void handleEvents() {
		_button = _app.mouseButton;
		if(!_moved) _moved = (_app.pmouseX != 0) || (_app.pmouseY != 0);
		else if(!_started) _started = true;
	}
	public float x() {
		return _app.mouseX;
	}
	public float y() {
		return _app.mouseY;
	}
	public HMouse move(float dx, float dy) {
		return this;
	}
}
