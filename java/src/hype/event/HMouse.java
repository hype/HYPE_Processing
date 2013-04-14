package hype.event;

import hype.util.HFollowable;
import processing.core.PApplet;

public class HMouse implements HFollowable {
	private static HMouse _instance;

	public static HMouse init(PApplet app) {
		return new HMouse(app);
	}
	
	public static HMouse instance() {
		return _instance;
	}
	
	
	private PApplet _app;
	
	public HMouse(PApplet app) {
		_app = app;
	}
	
	public void handleEvents() {
		// TODO
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
