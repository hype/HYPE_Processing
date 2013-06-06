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
import hype.extended.drawable.HPathNEW;
import processing.core.PGraphics;

public class HVertexNEW implements HLocatable {
	private HPathNEW _path;
	private byte _numControlPts;
	private float _u, _v, _cu1, _cv1, _cu2, _cv2;

	public HVertexNEW(HPathNEW parentPath) {
		_path = parentPath;
	}
	
	public HVertexNEW createCopy(HPathNEW newParentPath) {
		HVertexNEW copy = new HVertexNEW(newParentPath);
		copy._numControlPts = _numControlPts;
		copy._u = _u;
		copy._v = _v;
		copy._cu1 = _cu1;
		copy._cv1 = _cv1;
		copy._cu2 = _cu2;
		copy._cv2 = _cv2;
		return copy;
	}
	
	public HPathNEW path() {
		return _path;
	}
	
	public HVertexNEW numControlPts(byte b) {
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

	public HVertexNEW set(float x, float y) {
		return setUV(
			_path.x2u(x),   _path.y2v(y));
	}
	
	public HVertexNEW set(float cx, float cy, float x, float y) {
		return setUV(
			_path.x2u(cx), _path.y2v(cy),
			_path.x2u(x),   _path.y2v(y));
	}
	
	public HVertexNEW set(
		float cx1, float cy1,
		float cx2, float cy2,
		float x, float y
	) {
		return setUV(
			_path.x2u(cx1), _path.y2v(cy1),
			_path.x2u(cx2), _path.y2v(cy2),
			_path.x2u(x),   _path.y2v(y));
	}
	
	public HVertexNEW setUV(float u, float v) {
		_numControlPts = 0;
		_u = u;
		_v = v;
		return this;
	}

	public HVertexNEW setUV(float cu, float cv, float u, float v) {
		_numControlPts = 1;
		_u = u;
		_v = v;
		_cu1 = cu;
		_cv1 = cv;
		return this;
	}

	public HVertexNEW setUV(
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
	public HVertexNEW x(float f) {
		return u(_path.x2u(f));
	}

	@Override
	public float x() {
		return _path.u2x(_u - _path.anchorPercX());
	}

	@Override
	public HVertexNEW y(float f) {
		return v(_path.y2v(f));
	}

	@Override
	public float y() {
		return _path.v2y(_v - _path.anchorPercY());
	}

	@Override
	public HVertexNEW z(float f) {
		return this;
	}

	@Override
	public float z() {
		return 0;
	}

	public HVertexNEW u(float f) {
		_u = f;
		return this;
	}

	public float u() {
		return _u;
	}

	public HVertexNEW v(float f) {
		_v = f;
		return this;
	}

	public float v() {
		return _v;
	}

	public HVertexNEW cx(float f) {
		return cx1(f);
	}

	public float cx() {
		return cx1();
	}

	public HVertexNEW cy(float f) {
		return cy1(f);
	}

	public float cy() {
		return cy1();
	}

	public HVertexNEW cu(float f) {
		return cu1(f);
	}

	public float cu() {
		return cu1();
	}

	public HVertexNEW cv(float f) {
		return cv1(f);
	}

	public float cv() {
		return cv1();
	}

	public HVertexNEW cx1(float f) {
		return cu1(_path.x2u(f));
	}

	public float cx1() {
		return _path.u2x(_cu1 - _path.anchorPercX());
	}

	public HVertexNEW cy1(float f) {
		return cv1(_path.y2v(f));
	}

	public float cy1() {
		return _path.v2y(_cv1 - _path.anchorPercY());
	}

	public HVertexNEW cu1(float f) {
		_cu1 = f;
		return this;
	}

	public float cu1() {
		return _cu1;
	}

	public HVertexNEW cv1(float f) {
		_cv1 = f;
		return this;
	}

	public float cv1() {
		return _cv1;
	}

	public HVertexNEW cx2(float f) {
		return cu2(_path.x2u(f));
	}

	public float cx2() {
		return _path.u2x(_cu2 - _path.anchorPercX());
	}

	public HVertexNEW cy2(float f) {
		return cv2(_path.y2v(f));
	}

	public float cy2() {
		return _path.v2y(_cv2 - _path.anchorPercY());
	}

	public HVertexNEW cu2(float f) {
		_cu2 = f;
		return this;
	}

	public float cu2() {
		return _cu2;
	}

	public HVertexNEW cv2(float f) {
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
		
		if(_numControlPts > 0) {
			if(_cu1 < minmax[0]) minmax[0] = _cu1;
			else if(_cu1 > minmax[2]) minmax[2] = _cu1;
			
			if(_cv1 < minmax[1]) minmax[1] = _cv1;
			else if(_cv1 > minmax[3]) minmax[3] = _cv1;
			
			if(_numControlPts > 1) {
				if(_cu2 < minmax[0]) minmax[0] = _cu2;
				else if(_cu2 > minmax[2]) minmax[2] = _cu2;
				
				if(_cv2 < minmax[1]) minmax[1] = _cv2;
				else if(_cv2 > minmax[3]) minmax[3] = _cv2;
			}
		}
	}
	
	public void adjust(float offU, float offV, float scaleW, float scaleH) {
		_u += offU;
		_cu1 += offU;
		_cu2 += offU;
		if(scaleW != 0) {
			_u /= scaleW;
			_cu1 /= scaleW;
			_cu2 /= scaleW;
		}
		_v += offV;
		_cv1 += offV;
		_cv2 += offV;
		if(scaleH != 0) {
			_v /= scaleH;
			_cv1 /= scaleH;
			_cv2 /= scaleH;
		}
	}
	
	public int getCrossings(HVertexNEW prev, float tu, float tv) {
		int numCrossings = 0;
		
		if(isLine()) {
			float t = (tv-prev._v) / (_v-prev._v);
			if(0 < t && t <= 1) {
				float tmpU = prev._u + t*(_u-prev._u);
				if(tmpU == tu) return -1;
				if(tmpU < tu) ++numCrossings;
			}
		} else if(isQuadratic()) {
			float[] ts = new float[2];
			int numt = HMath.bezierParam(prev._v,_cv1,_v, tv, ts);
			for(int i=0; i<numt; ++i) {
				float t = ts[i];
				if(t <= 0) continue;
				float tmpU = HMath.bezierPoint(prev._u,_cu1,_u, t);
				if(tmpU == tu) return -1;
				if(tmpU < tu) ++numCrossings;
			}
		} else {
			float[] ts = new float[3];
			float numt = HMath.bezierParam(prev._v,_cv1,_cv2,_v, tv, ts);
			for(int i=0; i<numt; ++i) {
				float t = ts[i];
				if(t <= 0) continue;
				float tmpU = HMath.bezierPoint(prev._u,_cu1,_cu2,_u, t);
				if(tmpU == tu) return -1;
				if(tmpU < tu) ++numCrossings;
			}
		}
		return numCrossings;
	}
	
	public void draw(PGraphics g, boolean isSimple, boolean drawsHandles) {
		if(isLine() || isSimple) {
			g.vertex( x(), y() );
		} else if(isQuadratic()) {
			// TODO draw handles
			g.quadraticVertex( cx1(),cy1(), x(),y() );
		} else {
			// TODO draw handles
			g.bezierVertex( cx1(),cy1(), cx2(),cy2(), x(),y() );
		}
	}
	
}
