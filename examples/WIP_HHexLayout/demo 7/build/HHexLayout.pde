/*
 * HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 *
 * HHexLayout
 * by Russell Hay / http://cordandruss.com
 * https://github.com/RussTheAerialist
 *
 * Creates a grid layout that is hex based spiraling out from the center of the sketch
 *
 * References:
 *    http://www.redblobgames.com/grids/hexagons/
 *    http://gamedev.stackexchange.com/questions/51264/get-ring-of-tiles-in-hexagon-grid
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HHexLayout implements HLayout {
	protected int _currentDistanceFromCenter, _currentIndex, _direction;
	protected float _spacing, _offsetX, _offsetY, _adjustX, _adjustY;
	protected PVector _lastPoint;

	public HHexLayout() {
		_spacing = 16;
		_currentIndex = 0;
		_direction = 0;
		_currentDistanceFromCenter = 0;
		_offsetX = H.app().width / 2.0;
		_offsetY = H.app().height / 2.0;
		_adjustX = _spacing * 1.25;
		_adjustY = _spacing * 0.25;
		_lastPoint = null;
	}

	public HHexLayout spacing(float size) {
		_spacing = size;

		return this;
	}

	public float spacing() {
		return _spacing;
	}

	public HHexLayout offsetX(float value) {
		_adjustX = value;
		return this;
	}

	public HHexLayout offsetY(float value) {
		_adjustY = value;
		return this;
	}

	public float offsetX() { return _adjustX; }
	public float offsetY() { return _adjustY; }

	protected PVector north(PVector in) {
		return north(in, 1);
	}

	protected PVector north(PVector in, int distance) {
		return new PVector(in.x, in.y-distance);
	}

	protected PVector south(PVector in) {
		return new PVector(in.x, in.y+1);
	}

	protected PVector northeast(PVector in) {
		return new PVector(in.x+1, in.y-1);
	}

	protected PVector northwest(PVector in) {
		return new PVector(in.x-1, in.y);
	}

	protected PVector southeast(PVector in) {
		return new PVector(in.x+1, in.y);
	}

	protected PVector southwest(PVector in) {
		return new PVector(in.x-1, in.y+1);
	}

	protected void updateLastPoint() {

		// We've reached the end of the current direction, switch directions
		if (_currentIndex > _currentDistanceFromCenter-1) {
			_currentIndex = 0;
			_direction++;
		}

		// We've reached the end of the current ring, increase distance
		if (_direction > 5) {
			_direction = 0;
			_currentDistanceFromCenter++;
			_currentIndex = 0;
			_lastPoint = north(new PVector(0,0), _currentDistanceFromCenter);
			// return;
		}


		if (_lastPoint != null) {
			switch(_direction) {
				case 0:
					_lastPoint = southeast(_lastPoint);
					// PApplet.println(Integer.toString(_currentIndex) + ": SE : " + _lastPoint);
					break;
				case 1:
					_lastPoint = south(_lastPoint);
					// PApplet.println(Integer.toString(_currentIndex) + ": S  : " + _lastPoint);
					break;
				case 2:
					_lastPoint = southwest(_lastPoint);
					// PApplet.println(Integer.toString(_currentIndex) + ": SW : " + _lastPoint);
					break;
				case 3:
					_lastPoint = northwest(_lastPoint);
					// PApplet.println(Integer.toString(_currentIndex) + ": NW : " + _lastPoint);
					break;
				case 4:
					_lastPoint = north(_lastPoint);
					// PApplet.println(Integer.toString(_currentIndex) + ": N : " + _lastPoint);
					break;
				case 5:
					_lastPoint = northeast(_lastPoint);
					// PApplet.println(Integer.toString(_currentIndex) + ": NE : " + _lastPoint);
					break;
			}

		} else {
			// First point
			_lastPoint = new PVector(0,0);
			_currentIndex = _currentDistanceFromCenter+1;
			_direction = 7;
		}
	}

	public PVector getNextPoint() {
		++_currentIndex;
		updateLastPoint();

		float x, y;
		x = y = 0;

		x = _spacing * 3.0/2.0 * _lastPoint.x;
		y = _spacing * H.app().sqrt(3.0) * (_lastPoint.y + _lastPoint.x/2.0);

		PVector point = new PVector(
			x + _offsetX - _adjustX ,
			y + _offsetY - _adjustY
		);

		return point;

	}

	public void applyTo(HDrawable target) {
		target.loc(getNextPoint());
	}
}