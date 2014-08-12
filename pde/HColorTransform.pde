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
public static class HColorTransform implements HColorist {
	private float _percA, _percR, _percG, _percB;
	private int _offsetA, _offsetR, _offsetG, _offsetB;
	private boolean fillFlag, strokeFlag;
	public HColorTransform() {
		_percA = _percR = _percG = _percB = 1;
		fillAndStroke();
	}
	public HColorTransform offset(int off) {
		_offsetA = _offsetR = _offsetG = _offsetB = off;
		return this;
	}
	public HColorTransform offset(int r, int g, int b, int a) {
		_offsetA = a;
		_offsetR = r;
		_offsetG = g;
		_offsetB = b;
		return this;
	}
	public HColorTransform offsetA(int a) {
		_offsetA = a;
		return this;
	}
	public int offsetA() {
		return _offsetA;
	}
	public HColorTransform offsetR(int r) {
		_offsetR = r;
		return this;
	}
	public int offsetR() {
		return _offsetR;
	}
	public HColorTransform offsetG(int g) {
		_offsetG = g;
		return this;
	}
	public int offsetG() {
		return _offsetG;
	}
	public HColorTransform offsetB(int b) {
		_offsetB = b;
		return this;
	}
	public int offsetB() {
		return _offsetB;
	}
	public HColorTransform perc(float percentage) {
		_percA = _percR = _percG = _percB = percentage;
		return this;
	}
	public HColorTransform perc(int r, int g, int b, int a) {
		_percA = a;
		_percR = r;
		_percG = g;
		_percB = b;
		return this;
	}
	public HColorTransform percA(float a) {
		_percA = a;
		return this;
	}
	public float percA() {
		return _percA;
	}
	public HColorTransform percR(float r) {
		_percR = r;
		return this;
	}
	public float percR() {
		return _percR;
	}
	public HColorTransform percG(float g) {
		_percG = g;
		return this;
	}
	public float percG() {
		return _percG;
	}
	public HColorTransform percB(float b) {
		_percB = b;
		return this;
	}
	public float percB() {
		return _percB;
	}
	public HColorTransform mergeWith(HColorTransform other) {
		if(other != null) {
			_percA *= other._percA;
			_percR *= other._percR;
			_percG *= other._percG;
			_percB *= other._percB;
			_offsetA += other._offsetA;
			_offsetR += other._offsetR;
			_offsetG += other._offsetG;
			_offsetB += other._offsetB;
		}
		return this;
	}
	public HColorTransform createCopy() {
		HColorTransform copy = new HColorTransform();
		copy._percA = _percA;
		copy._percR = _percR;
		copy._percG = _percG;
		copy._percB = _percB;
		copy._offsetA = _offsetA;
		copy._offsetR = _offsetR;
		copy._offsetG = _offsetG;
		copy._offsetB = _offsetB;
		return copy;
	}
	public HColorTransform createNew(HColorTransform other) {
		return createCopy().mergeWith(other);
	}
	public int getColor(int origColor) {
		int[] clrs = HColors.explode(origColor);
		clrs[0] = Math.round(clrs[0] * _percA) + _offsetA;
		clrs[1] = Math.round(clrs[1] * _percR) + _offsetR;
		clrs[2] = Math.round(clrs[2] * _percG) + _offsetG;
		clrs[3] = Math.round(clrs[3] * _percB) + _offsetB;
		return HColors.merge(clrs[0],clrs[1],clrs[2],clrs[3]);
	}
	public HColorTransform fillOnly() {
		fillFlag = true;
		strokeFlag = false;
		return this;
	}
	public HColorTransform strokeOnly() {
		fillFlag = false;
		strokeFlag = true;
		return this;
	}
	public HColorTransform fillAndStroke() {
		fillFlag = strokeFlag = true;
		return this;
	}
	public boolean appliesFill() {
		return fillFlag;
	}
	public boolean appliesStroke() {
		return strokeFlag;
	}
	public HDrawable applyColor(HDrawable drawable) {
		if(fillFlag) {
			int fill = drawable.fill();
			drawable.fill( getColor(fill) );
		}
		if(strokeFlag) {
			int stroke = drawable.stroke();
			drawable.stroke( getColor(stroke) );
		}
		return drawable;
	}
}
