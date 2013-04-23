package hype.event;

import hype.interfaces.HFollowable;
import processing.core.PApplet;

public class HMouse implements HFollowable {
	private PApplet _app;
	private boolean _started;
	
	public HMouse(PApplet app) {
		_app = app;
	}
	
	public boolean started() {
		return _started;
	}
	
	public void handleEvents() {
		if(!_started && _app.pmouseX+_app.pmouseY > 0)
			_started = true;
	}

	@Override
	public float followableX() {
		return _app.mouseX;
	}

	@Override
	public float followableY() {
		return _app.mouseY;
	}
}
