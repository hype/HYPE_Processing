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
public static class HShapeLayout implements HLayout {
	private HDrawable _target;
	private float[] _bounds;
	private int _iterationLimit;
	public HShapeLayout() {
		_iterationLimit = 1024;
		_bounds = new float[4];
	}
	public HShapeLayout iterationLimit(int i) {
		_iterationLimit = i;
		return this;
	}
	public int iterationLimit() {
		return _iterationLimit;
	}
	public HShapeLayout target(HDrawable d) {
		_target = d;
		if(_target != null) _target.bounds(_bounds);
		return this;
	}
	public HDrawable target() {
		return _target;
	}
	public void applyTo(HDrawable target) {
		PVector pt = getNextPoint();
		if(pt != null) target.loc(pt);
	}
	public PVector getNextPoint() {
		if(_target == null) return null;
		float x1 = _bounds[0];
		float y1 = _bounds[1];
		float x2 = _bounds[0] + _bounds[2];
		float y2 = _bounds[1] + _bounds[3];
		for(int i=0; i<_iterationLimit; ++i) {
			float x = H.app().random(x1,x2);
			float y = H.app().random(y1,y2);
			if(_target.contains(x,y))
				return new PVector(x,y);
		}
		return null;
	}
}
