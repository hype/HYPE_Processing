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

package hype.extended.util;

import hype.core.interfaces.HLocatable;
import hype.core.util.HMath;
import hype.extended.drawable.HPath;
import processing.core.PGraphics;

public class HVertex implements HLocatable {
	public static final float LINE_TOLERANCE = 1.5f;
	
	private HPath _path;
	private byte _numControlPts;
	private float _u, _v, _cu1, _cv1, _cu2, _cv2;

	public HVertex(HPath parentPath) {
		_path = parentPath;
	}
	
	public HVertex createCopy(HPath newParentPath) {
		HVertex copy = new HVertex(newParentPath);
		copy._numControlPts = _numControlPts;
		copy._u = _u;
		copy._v = _v;
		copy._cu1 = _cu1;
		copy._cv1 = _cv1;
		copy._cu2 = _cu2;
		copy._cv2 = _cv2;
		return copy;
	}
	
	public HPath path() {
		return _path;
	}
	
	public HVertex numControlPts(byte b) {
		_numControlPts = b;
		return this;
	}
	
	public byte numControlPts() {
		return _numControlPts;
	}
	
	public boolean isLine() {
		return (_numControlPts <= 0);
	}
	
	public boolean isCurved() {
		return (_numControlPts > 0);
	}

	public boolean isQuadratic() {
		return (_numControlPts == 1);
	}

	public boolean isCubic() {
		return (_numControlPts >= 2);
	}

	public HVertex set(float x, float y) {
		return setUV(
			_path.x2u(x),   _path.y2v(y));
	}
	
	public HVertex set(float cx, float cy, float x, float y) {
		return setUV(
			_path.x2u(cx), _path.y2v(cy),
			_path.x2u(x),  _path.y2v(y));
	}
	
	public HVertex set(
		float cx1, float cy1,
		float cx2, float cy2,
		float x, float y
	) {
		return setUV(
			_path.x2u(cx1), _path.y2v(cy1),
			_path.x2u(cx2), _path.y2v(cy2),
			_path.x2u(x),   _path.y2v(y));
	}
	
	public HVertex setUV(float u, float v) {
		_numControlPts = 0;
		_u = u;
		_v = v;
		return this;
	}

	public HVertex setUV(float cu, float cv, float u, float v) {
		_numControlPts = 1;
		_u = u;
		_v = v;
		_cu1 = cu;
		_cv1 = cv;
		return this;
	}

	public HVertex setUV(
		float cu1, float cv1,
		float cu2, float cv2,
		float u, float v
	) {
		_numControlPts = 2;
		_u = u;
		_v = v;
		_cu1 = cu1;
		_cv1 = cv1;
		_cu2 = cu2;
		_cv2 = cv2;
		return this;
	}
	
	@Override
	public HVertex x(float f) {
		return u(_path.x2u(f));
	}

	@Override
	public float x() {
		return _path.u2x(_u);
	}

	@Override
	public HVertex y(float f) {
		return v(_path.y2v(f));
	}

	@Override
	public float y() {
		return _path.v2y(_v);
	}

	@Override
	public HVertex z(float f) {
		return this;
	}

	@Override
	public float z() {
		return 0;
	}

	public HVertex u(float f) {
		_u = f;
		return this;
	}

	public float u() {
		return _u;
	}

	public HVertex v(float f) {
		_v = f;
		return this;
	}

	public float v() {
		return _v;
	}

	public HVertex cx(float f) {
		return cx1(f);
	}

	public float cx() {
		return cx1();
	}

	public HVertex cy(float f) {
		return cy1(f);
	}

	public float cy() {
		return cy1();
	}

	public HVertex cu(float f) {
		return cu1(f);
	}

	public float cu() {
		return cu1();
	}

	public HVertex cv(float f) {
		return cv1(f);
	}

	public float cv() {
		return cv1();
	}

	public HVertex cx1(float f) {
		return cu1(_path.x2u(f));
	}

	public float cx1() {
		return _path.u2x(_cu1);
	}

	public HVertex cy1(float f) {
		return cv1(_path.y2v(f));
	}

	public float cy1() {
		return _path.v2y(_cv1);
	}

	public HVertex cu1(float f) {
		_cu1 = f;
		return this;
	}

	public float cu1() {
		return _cu1;
	}

	public HVertex cv1(float f) {
		_cv1 = f;
		return this;
	}

	public float cv1() {
		return _cv1;
	}

	public HVertex cx2(float f) {
		return cu2(_path.x2u(f));
	}

	public float cx2() {
		return _path.u2x(_cu2);
	}

	public HVertex cy2(float f) {
		return cv2(_path.y2v(f));
	}

	public float cy2() {
		return _path.v2y(_cv2);
	}

	public HVertex cu2(float f) {
		_cu2 = f;
		return this;
	}

	public float cu2() {
		return _cu2;
	}

	public HVertex cv2(float f) {
		_cv2 = f;
		return this;
	}

	public float cv2() {
		return _cv2;
	}
	
	public void computeMinMax(float[] minmax) {
		if(_u < minmax[0]) minmax[0] = _u;
		else if(_u > minmax[2]) minmax[2] = _u;
		
		if(_v < minmax[1]) minmax[1] = _v;
		else if(_v > minmax[3]) minmax[3] = _v;
		
		switch(_numControlPts) {
		case 2:
			if(_cu2 < minmax[0]) minmax[0] = _cu2;
			else if(_cu2 > minmax[2]) minmax[2] = _cu2;
			
			if(_cv2 < minmax[1]) minmax[1] = _cv2;
			else if(_cv2 > minmax[3]) minmax[3] = _cv2;
		case 1:
			if(_cu1 < minmax[0]) minmax[0] = _cu1;
			else if(_cu1 > minmax[2]) minmax[2] = _cu1;
			
			if(_cv1 < minmax[1]) minmax[1] = _cv1;
			else if(_cv1 > minmax[3]) minmax[3] = _cv1;
			break;
		default: break;
		}
	}
	
	public void adjust(float offsetU, float offsetV, float oldW, float oldH) {
		x( oldW*(_u += offsetU) ).y( oldH*(_v += offsetV) );
		
		switch(_numControlPts) {
		case 2: cx2( oldW*(_cu2 += offsetU) ).cy2( oldH*(_cv2 += offsetV) );
		case 1: cx1( oldW*(_cu1 += offsetU) ).cy1( oldH*(_cv1 += offsetV) );
			break;
		default: break;
		}
	}
	
	private float dv(float pv, float t) {
		switch(_numControlPts) {
		case 1: return HMath.bezierTangent(pv,_cv1,_v, t);
		case 2: return HMath.bezierTangent(pv,_cv2,_cv2,_v, t);
		default: return _v - pv;
		}
	}
	
	public boolean intersectTest(
		HVertex pprev, HVertex prev,
		float tu, float tv, boolean openPath
	) {
		// TODO use pixels with the tolerance
		float u1 = prev._u;
		float v1 = prev._v;
		float u2 = _u;
		float v2 = _v;
		
		if(isLine() || openPath) {
			return ((v1<=tv && tv<v2) || (v2<=tv && tv<v1)) && 
				tu < (u1 + (u2-u1)*(tv-v1)/(v2-v1));
		} else if(isQuadratic()) {
			boolean b = false;
			float[] params = new float[2];
			int numParams = HMath.bezierParam(v1,_cv1,v2, tv, params);
			
			for(int i=0; i<numParams; ++i) {
				float t = params[i];
				if(0<t && t<1 && tu<HMath.bezierPoint(u1,_cu1,u2, t)) {
					if(HMath.bezierTangent(v1,_cv1,v2, t) == 0) continue;
					b = !b;
				} else if(t==0 && tu<u1) {
					float ptanv = prev.dv(pprev._v,1);
					if(ptanv==0) ptanv = prev.dv(pprev._v,0.9375f);
					float ntanv = HMath.bezierTangent(v1,_cv1,v2, 0);
					if(ntanv==0) ntanv=HMath.bezierTangent(v1,_cv1,v2, 0.0625f);
					if(ptanv<0 == ntanv<0) b = !b;
				}
			}
			return b;
		} else {
			boolean b = false;
			float[] params = new float[3];
			int numParams = HMath.bezierParam(v1,_cv1,_cv2,v2, tv, params);
			
			for(int i=0; i<numParams; ++i) {
				float t = params[i];
				if(0<t && t<1 && tu<HMath.bezierPoint(u1,_cu1,_cu2,u2, t)) {
					if(HMath.bezierTangent(v1,_cv1,_cv2,_v, t) == 0) {
						float ptanv = HMath.bezierTangent(
							v1,_cv1,_cv2,v2, Math.max(t-0.0625f, 0));
						float ntanv = HMath.bezierTangent(
							v1,_cv1,_cv2,v2, Math.min(t+.0625f, 1));
						if(ptanv<0 != ntanv<0) continue;
					}
					b = !b;
				} else if(t==0 && tu<u1) {
					float ptanv = prev.dv(pprev._v,1);
					if(ptanv==0) ptanv = prev.dv(pprev._v,0.9375f);
					float ntanv = HMath.bezierTangent(v1,_cv1,_cv2, 0);
					if(ntanv==0) ntanv = HMath.bezierTangent(
						v1,_cv1,_cv2,v2, 0.0625f);
					if(ptanv<0 == ntanv<0) b = !b;
				}
			}
			return b;
		}
	}
	
	public boolean inLine(HVertex prev, float relX, float relY) {
		float x1 = prev.x();
		float y1 = prev.y();
		float x2 = x();
		float y2 = y();
		
		if(isLine()) {
			float diffv = y2-y1;
			if(diffv == 0) {
				return HMath.isEqual(relY, y1, LINE_TOLERANCE) &&
					( (x1<=relX && relX<=x2)||(x2<=relX && relX<=x1) );
			}
			float t = (relY-y1) / diffv;
			return (0<=t && t<=1) &&
				HMath.isEqual(relX, x1+(x2-x1)*t, LINE_TOLERANCE);
		} else if(isQuadratic()) {
			float[] params = new float[2];
			int numParams = HMath.bezierParam(y1,cy1(),y2, relY, params);
			
			for(int i=0; i<numParams; ++i) {
				float t = params[i];
				if(0<=t && t<=1) {
					float bzval = HMath.bezierPoint(x1,cx1(),x2, t);
					if(HMath.isEqual(relX, bzval, LINE_TOLERANCE)) return true;
				}
			}
			return false;
		} else {
			float[] params = new float[3];
			int numParams = HMath.bezierParam(y1,cy1(),cy2(),y2, relY, params);
			
			for(int i=0; i<numParams; ++i) {
				float t = params[i];
				if(0<=t && t<=1) {
					float bzval = HMath.bezierPoint(x1,cx1(),cx2(),x2, t);
					if(HMath.isEqual(relX, bzval, LINE_TOLERANCE)) return true;
				}
			}
			return false;
		}
	}
	
	public void draw(PGraphics g, float drawX, float drawY, boolean isSimple) {
		float drX = drawX + x();
		float drY = drawY + y();
		
		if(isLine() || isSimple) {
			g.vertex(drX, drY);
		} else if(isQuadratic()) {
			float drCX = drawX + cx1();
			float drCY = drawY + cy1();
			
			g.quadraticVertex(drCX,drCY, drX,drY);
		} else {
			float drCX1 = drawX + cx1();
			float drCY1 = drawY + cy1();
			float drCX2 = drawX + cx2();
			float drCY2 = drawY + cy2();
			
			g.bezierVertex(drCX1,drCY1, drCX2,drCY2, drX,drY);
		}
	}
	
	public void drawHandles(PGraphics g, HVertex prev,float drawX,float drawY) {
		if(isLine()) return;
		
		float x1 = drawX + prev.x();
		float y1 = drawY + prev.y();
		float x2 = drawX + x();
		float y2 = drawY + y();
		
		g.fill(HPath.HANDLE_FILL);
		g.stroke(HPath.HANDLE_STROKE);
		g.strokeWeight(HPath.HANDLE_STROKE_WEIGHT);
		
		if(isQuadratic()) {
			float drCX = drawX + cx1();
			float drCY = drawY + cy1();
			
			g.line(x1,y1, drCX,drCY);
			g.line(x2,y2, drCX,drCY);
			g.ellipse(drCX, drCY, HPath.HANDLE_SIZE,HPath.HANDLE_SIZE);
			g.fill(HPath.HANDLE_STROKE);
			g.ellipse(x1,y1, HPath.HANDLE_SIZE/2,HPath.HANDLE_SIZE/2);
			g.ellipse(x2,y2, HPath.HANDLE_SIZE/2,HPath.HANDLE_SIZE/2);
		} else {
			float drCX1 = drawX + cx1();
			float drCY1 = drawY + cy1();
			float drCX2 = drawX + cx2();
			float drCY2 = drawY + cy2();
			
			g.line(x1,y1, drCX1,drCY1);
			g.line(x2,y2, drCX2,drCY2);
			g.line(drCX1,drCY1, drCX2,drCY2);
			g.ellipse(drCX1, drCY1, HPath.HANDLE_SIZE,HPath.HANDLE_SIZE);
			g.ellipse(drCX2,drCY2, HPath.HANDLE_SIZE,HPath.HANDLE_SIZE);
			g.fill(HPath.HANDLE_STROKE);
			g.ellipse(x1,y1, HPath.HANDLE_SIZE/2,HPath.HANDLE_SIZE/2);
			g.ellipse(x2,y2, HPath.HANDLE_SIZE/2,HPath.HANDLE_SIZE/2);
		}
	}
}
