/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.core.util;

import hype.core.interfaces.HLocatable;

public class HVector implements HLocatable {
	private float _x, _y, _z;
	
	public HVector() {}
	
	public HVector(float xCoord, float yCoord) {
		_x = xCoord;
		_y = yCoord;
	}
	
	public HVector(float xCoord, float yCoord, float zCoord) {
		_x = xCoord;
		_y = yCoord;
		_z = zCoord;
	}
	
	@Override
	public float x() {
		return _x;
	}
	
	@Override
	public HVector x(float newX) {
		_x = newX;
		return this;
	}

	@Override
	public float y() {
		return _y;
	}

	@Override
	public HVector y(float newY) {
		_y = newY;
		return this;
	}

	@Override
	public float z() {
		return _z;
	}

	@Override
	public HVector z(float newZ) {
		_z = newZ;
		return this;
	}
}
