package hype.util;

import hype.interfaces.HGoal;
import processing.core.PVector;

public class HVector extends PVector implements HGoal {
	private static final long serialVersionUID = 1;
	
	public HVector() {
		super();
	}
	
	public HVector(float xCoord, float yCoord) {
		super(xCoord, yCoord);
	}
	
	@Override
	public float x() {
		return x;
	}

	@Override
	public float y() {
		return y;
	}

	@Override
	public HVector move(float dx, float dy) {
		x += dx;
		y += dy;
		return this;
	}

	@Override
	public float followableX() {
		return x;
	}

	@Override
	public float followableY() {
		return y;
	}
}
