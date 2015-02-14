/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * based on old AS3 layout by Michael Svendsen / twitter.com/michaelSvendsen
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HPolarLayout implements HLayout {
	private int _index;
	private float _length, _angleStep, _scaleMultiplier, _offsetX, _offsetY;
	private Boolean _scaleByDistance;
	public HPolarLayout() {
		_index = 0;
		_length = 1;
		_angleStep = 0.1;
		_offsetX = 0;
		_offsetY = 0;
		_scaleByDistance = false;
		_scaleMultiplier = 0;
	}
	public HPolarLayout(float length, float angleStep) {
		_index = 0;
		_length = length;
		_angleStep = angleStep;
		_offsetX = 0;
		_offsetY = 0;
		_scaleByDistance = false;
		_scaleMultiplier = 0;
	}
	public HPolarLayout offset(float x, float y) {
		_offsetX = x;
		_offsetY = y;
		return this;
	}
	public HPolarLayout offsetX(float f) {
		_offsetX = f;
		return this;
	}
	public HPolarLayout offsetY(float f) {
		_offsetY = f;
		return this;
	}
	public HPolarLayout scale(float f) {
		_scaleByDistance = true;
		_scaleMultiplier = f;
		return this;
	}
	private void applyScale(HDrawable target) {
		float d = HMath.dist( _offsetX, _offsetY, target.x(), target.y() );
		target.scale(d * _scaleMultiplier);
	}
	public PVector getNextPoint() {
		PVector pt = new PVector();
		float r     = _index * _length;
		float theta = _index * _angleStep;
		pt.x = r * cos(theta) + _offsetX;
		pt.y = r * sin(theta) + _offsetY;
		++_index;
		return pt;
	}
	public void applyTo(HDrawable target) {
		target.loc(getNextPoint());
		if (_scaleByDistance == true) {
			applyScale(target);
		}
	}
}
