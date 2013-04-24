package hype.drawable;

import hype.util.H;
import hype.util.HMath;
import processing.core.PApplet;
import processing.core.PConstants;

public class HEllipse extends HDrawable {
	protected int _mode;
	protected float _startRad, _endRad;
	
	public HEllipse() {
		_mode = PConstants.PIE;
	}
	
	public HEllipse(float ellipseRadius) {
		this();
		radius(ellipseRadius);
	}
	
	public HEllipse(float radiusX, float radiusY) {
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
		_startRad = rad;
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
		_endRad = rad;
		return this;
	}
	
	public float endRad() {
		return _endRad;
	}
	
	@SuppressWarnings("static-access")
	@Override
	public boolean containsRel(float relX, float relY) {
		float cx = _width/2;
		float cy = _height/2;
		float dcx = relX - cx;
		float dcy = relY - cy;
		
		boolean inEllipse = ((dcx*dcx)/(cx*cx) + (dcy*dcy)/(cy*cy) <= 1);
		
		// If mode is closed, just check if it's in the ellipse
		if(_startRad == _endRad) return inEllipse;
		else if(!inEllipse) return false;
		
		
		// If mode is pie, check if it's between start and end angles 
		PApplet app = H.app();
		float arcAngle = _endRad - _startRad;
		float ptAngle = app.atan2(dcy, dcx);
		// TODO normalize angles and stuff
		boolean inAngle = (_startRad<=ptAngle && ptAngle<=_endRad);
		if(!inAngle) {
			ptAngle += PConstants.TWO_PI;
			inAngle = (_startRad<=ptAngle && ptAngle<=_endRad);
		}
		
		if(_mode==PConstants.PIE || arcAngle==PConstants.PI) return inAngle;
		
		
		// If mode is chord or open, check if the mode is in the chord triangle 
		float a = _width/2;
		float b = _height/2;
		float[] endPt = HMath.ellipsePointRadArr(cx,cy, a,b, _endRad);
		float[] startPt = HMath.ellipsePointRadArr(cx,cy, a,b, _startRad);
		float[] xs = {cx, endPt[0], startPt[0]};
		float[] ys = {cy, endPt[1], startPt[1]};
		boolean inTriangle = false;
		
		for(int i=0; i<xs.length; ++i) {
			float x1 = xs[i];
			float y1 = ys[i];
			int j = (i==xs.length)? 0 : i;
			float x2 = xs[j];
			float y2 = ys[j];
			
			float t = (relY-y1) / (y2-y1);
			if(0<t && t<=1) {
				float currX = x1 + (x2-x1)*t;
				if(currX < relX) inTriangle = !inTriangle;
			}
		}
		return (arcAngle > PConstants.PI) == (inTriangle || inAngle);
	}
	
	@Override
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {
		applyStyle(app,currAlphaPerc);
		
		drawX += _width/2;
		drawY += _height/2;
		
		if(_startRad == _endRad) {
			app.ellipse(drawX, drawY, _width, _height);
		} else {
			app.arc(drawX,drawY,_width,_height,_startRad,_endRad,_mode);
		}
	}
}
