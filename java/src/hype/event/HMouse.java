package hype.event;

import hype.interfaces.HLocatable;
import processing.core.PApplet;

public class HMouse implements HLocatable {
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
	public float x() {
		return _app.mouseX;
	}

	@Override
	public float y() {
		return _app.mouseY;
	}

	@Override
	public HMouse move(float dx, float dy) {
		return this;
	}
}
