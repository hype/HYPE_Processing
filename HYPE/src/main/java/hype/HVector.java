package hype;

import hype.interfaces.HLocatable;

public class HVector implements HLocatable {
	private float x, y, z;

	public HVector() {}

	public HVector(float xCoord, float yCoord) {
		x = xCoord;
		y = yCoord;
	}

	public HVector(float xCoord, float yCoord, float zCoord) {
		x = xCoord;
		y = yCoord;
		z = zCoord;
	}

	@Override
	public float x() {
		return x;
	}

	@Override
	public HVector x(float newX) {
		x = newX;
		return this;
	}

	@Override
	public float y() {
		return y;
	}

	@Override
	public HVector y(float newY) {
		y = newY;
		return this;
	}

	@Override
	public float z() {
		return z;
	}

	@Override
	public HVector z(float newZ) {
		z = newZ;
		return this;
	}
}
