package hype;

import hype.interfaces.HLocatable;
import processing.core.PApplet;

public class HMouse implements HLocatable {
	private PApplet app;
	private int button;
	private boolean started, moved;

	public HMouse(PApplet app) {
		this.app = app;
	}

	public boolean started() {
		return started;
	}

	public boolean moved() {
		return moved;
	}

	public int button() {
		return button;
	}

	public void handleEvents() {
		button = app.mouseButton;

		if(!moved) moved = (app.pmouseX != 0) || (app.pmouseY != 0);
		else if(!started) started = true;
	}

	@Override
	public float x() {
		return app.mouseX;
	}

	@Override
	public HMouse x(float newX) {
		return this;
	}

	@Override
	public float y() {
		return app.mouseY;
	}

	@Override
	public HMouse y(float newY) {
		return this;
	}

	@Override
	public float z() {
		return 0;
	}

	@Override
	public HMouse z(float newZ) {
		return this;
	}
}
