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

package hype.extended.drawable;

import hype.core.drawable.HDrawable;
import hype.core.util.H;
import hype.core.util.HMath;
import processing.core.PConstants;
import processing.core.PGraphics;

public class HEllipse extends HDrawable {
	private int _mode;
	private float _startRad, _endRad;
	
	public HEllipse() {
		_mode = PConstants.PIE;
	}
	
	public HEllipse(float ellipseRadius) {
		this();
		radius(ellipseRadius);
	}
	
	public HEllipse(float radiusX, float radiusY) {
		this();
		radius(radiusX,radiusY);
	}
	
	@Override
	public HEllipse createCopy() {
		HEllipse copy = new HEllipse();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	public HEllipse radius(float r) {
		size(r*2);
		return this;
	}
	
	public HEllipse radius(float radiusX, float radiusY) {
		size(radiusX*2,radiusY*2);
		return this;
	}
	
	public HEllipse radiusX(float radiusX) {
		width(radiusX * 2);
		return this;
	}
	
	public float radiusX() {
		return _width/2;
	}
	
	public HEllipse radiusY(float radiusY) {
		height(radiusY * 2);
		return this;
	}
	
	public float radiusY() {
		return _height/2;
	}
	
	public boolean isCircle() {
		return _width == _height;
	}
	
	public HEllipse mode(int t) {
		_mode = t;
		return this;
	}
	
	public float mode() {
		return _mode;
	}
	
	public HEllipse start(float deg) {
		return startRad(deg * H.D2R);
	}
	
	public float start() {
		return _startRad * H.R2D;
	}
	
	public HEllipse startRad(float rad) {
		_startRad = HMath.normalizeAngleRad(rad);
		if(_startRad > _endRad) _endRad += PConstants.TWO_PI;
		return this;
	}
	
	public float startRad() {
		return _startRad;
	}
	
	public HEllipse end(float deg) {
		return endRad(deg * H.D2R);
	}
	
	public float end() {
		return _endRad * H.R2D;
	}
	
	public HEllipse endRad(float rad) {
		_endRad = HMath.normalizeAngleRad(rad);
		if(_startRad > _endRad) _endRad += PConstants.TWO_PI;
		return this;
	}
	
	public float endRad() {
		return _endRad;
	}
	
	@Override
	public boolean containsRel(float relX, float relY) {
		float cx = _width/2;
		float cy = _height/2;
		float dcx = relX - cx;
		float dcy = relY - cy;
		
		boolean inEllipse = ((dcx*dcx)/(cx*cx) + (dcy*dcy)/(cy*cy) <= 1);
		
		// If mode is closed, just check if it's in the ellipse
		if(_startRad == _endRad) return inEllipse;
		
		// Return false regardless of mode if it's not inside the ellipse
		else if(!inEllipse) return false;
		
		if(_mode == PConstants.PIE) {
			float ptAngle = (float) Math.atan2(dcy*cx, dcx*cy);
			if(_startRad > ptAngle) ptAngle += PConstants.TWO_PI;
			return (_startRad<=ptAngle && ptAngle<=_endRad);
		} else {
			float end = HMath.squishAngleRad(cx, cy, _endRad);
			float start = HMath.squishAngleRad(cx, cy, _startRad);
			float[] pt1 = HMath.ellipsePointRadArr(cx,cy, cx,cy, end);
			float[] pt2 = HMath.ellipsePointRadArr(cx,cy, cx,cy, start);
			return HMath.rightOfLine(pt1[0],pt1[1], pt2[0],pt2[1], relX,relY);
		}
	}
	
	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX,float drawY,float alphaPc
	) {
		applyStyle(g,alphaPc);
		
		drawX += _width/2;
		drawY += _height/2;
		
		if(_startRad == _endRad) {
			g.ellipse(drawX, drawY, _width, _height);
		} else {
			g.arc(drawX,drawY,_width,_height,_startRad,_endRad,_mode);
		}
	}
}
