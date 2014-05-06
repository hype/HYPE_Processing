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

package hype.extended.layout;

import hype.core.drawable.HDrawable;
import hype.core.layout.HLayout;
import processing.core.PVector;

public class HGridLayout implements HLayout {
	private int _currentIndex, _numCols, _numRows;
	private float _startX, _startY, _startZ, _xSpace, _ySpace, _zSpace;

	public HGridLayout() {
		_xSpace = _ySpace = _zSpace = _numCols = 16;
		_numRows = 0;
	}
	
	public HGridLayout(int numOfColumns) {
		this();
		_numCols = numOfColumns;
	}

	public HGridLayout(int numOfColumns, int numOfRows) {
		this();
		_numCols = numOfColumns;
		_numRows = numOfRows;
	}
	
	public HGridLayout currentIndex(int i) {
		_currentIndex = i;
		return this;
	}
	
	public int currentIndex() {
		return _currentIndex;
	}
	
	public HGridLayout resetIndex() {
		_currentIndex = 0;
		return this;
	}
	
	public HGridLayout cols(int numOfColumns) {
		_numCols = numOfColumns;
		return this;
	}
	
	public int cols() {
		return _numCols;
	}

	public HGridLayout rows(int numOfRows) {
		_numRows = numOfRows;
		return this;
	}
	
	public int rows() {
		return _numRows;
	}
	
	public PVector startLoc() {
		return new PVector(_startX, _startY, _startZ);
	}
	
	public HGridLayout startLoc(float x, float y) {
		_startX = x;
		_startY = y;
		_startZ = 0;
		return this;
	}

	public HGridLayout startLoc(float x, float y, float z) {
		_startX = x;
		_startY = y;
		_startZ = z;
		return this;
	}
	
	public float startX() {
		return _startX;
	}
	
	public HGridLayout startX(float x) {
		_startX = x;
		return this;
	}
	
	public float startY() {
		return _startY;
	}
	
	public HGridLayout startY(float y) {
		_startY = y;
		return this;
	}

	public float startZ() {
		return _startZ;
	}
	
	public HGridLayout startZ(float z) {
		_startZ = z;
		return this;
	}
	
	public PVector spacing() {
		return new PVector(_xSpace, _ySpace, _zSpace);
	}
	
	public HGridLayout spacing(float xSpacing, float ySpacing) {
		_xSpace = xSpacing;
		_ySpace = ySpacing;
		return this;
	}

	public HGridLayout spacing(float xSpacing, float ySpacing, float zSpacing) {
		_xSpace = xSpacing;
		_ySpace = ySpacing;
		_zSpace = zSpacing;
		return this;
	}
	
	public float spacingX() {
		return _xSpace;
	}
	
	public HGridLayout spacingX(float xSpacing) {
		_xSpace = xSpacing;
		return this;
	}
	
	public float spacingY() {
		return _ySpace;
	}
	
	public HGridLayout spacingY(float ySpacing) {
		_ySpace = ySpacing;
		return this;
	}

	public float spacingZ() {
		return _zSpace;
	}
	
	public HGridLayout spacingZ(float zSpacing) {
		_zSpace = zSpacing;
		return this;
	}
	
	@Override
	public PVector getNextPoint() {

		int layer = 0;
		int row = 0;
		int col = _currentIndex % _numCols;

		if (_numRows > 0) {
			layer = (int) Math.floor( _currentIndex / (_numCols * _numRows) );
			row = (int) Math.floor(_currentIndex / _numCols) - (layer * _numRows);
		} else {
			row = (int) Math.floor(_currentIndex / _numCols);
		}

		++_currentIndex;

		if (_numRows > 0) {
			return new PVector(col*_xSpace + _startX, row*_ySpace + _startY, layer*_zSpace + _startZ);
		} else {
			return new PVector(col*_xSpace + _startX, row*_ySpace + _startY);
		}
	}

	@Override
	public void applyTo(HDrawable target) {
		target.loc(getNextPoint());
	}
}
