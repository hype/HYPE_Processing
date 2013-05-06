package hype.util;

import hype.interfaces.HLocatable;
import processing.core.PVector;

public class HVector extends PVector implements HLocatable {
	private static final long serialVersionUID = 1;
	
	public HVector() {
		super();
	}
	
	public HVector(float xCoord, float yCoord) {
		super(xCoord, yCoord);
	}
	
	public HVector(float xCoord, float yCoord, float zCoord) {
		super(xCoord, yCoord, zCoord);
	}
	
	@Override
	public float x() {
		return super.x;
	}
	
	@Override
	public HVector x(float newX) {
		super.x = newX;
		return this;
	}

	@Override
	public float y() {
		return super.y;
	}

	@Override
	public HVector y(float newY) {
		super.y = newY;
		return this;
	}

	@Override
	public float z() {
		return super.z;
	}

	@Override
	public HVector z(float newZ) {
		super.z = newZ;
		return this;
	}
}
