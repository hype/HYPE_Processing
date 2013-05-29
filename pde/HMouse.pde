/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HMouse implements HLocatable {
	private PApplet _app;
	private int _button;
	private boolean _started, _moved;
	public HMouse(PApplet app) {
		_app = app;
	}
	public boolean started() {
		return _started;
	}
	public boolean moved() {
		return _moved;
	}
	public int button() {
		return _button;
	}
	public void handleEvents() {
		_button = _app.mouseButton;
		if(!_moved) _moved = (_app.pmouseX != 0) || (_app.pmouseY != 0);
		else if(!_started) _started = true;
	}
	public float x() {
		return _app.mouseX;
	}
	public HMouse x(float newX) {
		return this;
	}
	public float y() {
		return _app.mouseY;
	}
	public HMouse y(float newY) {
		return this;
	}
	public float z() {
		return 0;
	}
	public HMouse z(float newZ) {
		return this;
	}
}
