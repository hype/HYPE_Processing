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
public static class HPath extends HDrawable {
	private ArrayList<HVertex> _vertices;
	private int _mode;
	public HPath() {
		this(PConstants.PATH);
	}
	public HPath(int pathMode) {
		_vertices = new ArrayList<HPath.HVertex>();
		_mode = pathMode;
	}
	public HPath createCopy() {
		HPath copy = new HPath();
		copy.copyPropertiesFrom(this);
		for(int i=0; i<_vertices.size(); ++i) {
			HVertex v = _vertices.get(i);
			HVertex vcopy = new HVertex();
			vcopy.x = v.x;
			vcopy.y = v.y;
			vcopy.hx1 = v.hx1;
			vcopy.hy1 = v.hy1;
			vcopy.hx2 = v.hx2;
			vcopy.hy2 = v.hy2;
			vcopy.isBezier = v.isBezier;
			copy._vertices.add(vcopy);
		}
		return copy;
	}
	public HPath mode(int m) {
		_mode = m;
		return this;
	}
	public int mode() {
		return _mode;
	}
	public HVertex vertex(int index) {
		return _vertices.get(index);
	}
	public HPath removeVertex(int index) {
		_vertices.remove(index);
		return this;
	}
	public int numVertices() {
		return _vertices.size();
	}
	public HPath endPath() {
		int numVertices = _vertices.size();
		float minX, maxX, minY, maxY;
		minX = maxX = minY = maxY = 0;
		for(int i=0; i<numVertices; ++i) {
			HVertex v = _vertices.get(i);
			if(v.x < minX) minX = v.x;
			else if(v.x > maxX) maxX = v.x;
			if(v.y < minY) minY = v.y;
			else if(v.y > maxY) maxY = v.y;
		}
		float ratioX = maxX - minX;
		float ratioY = maxY - minY;
		scale(ratioX, ratioY);
		anchorPercX((ratioX==0)? 0 : -minX/ratioX);
		anchorPercY((ratioY==0)? 0 : -minY/ratioY);
		for(int j=0; j<numVertices; ++j) {
			HVertex w = _vertices.get(j);
			w.x -= minX;
			w.hx1 -= minX;
			w.hx2 -= minX;
			if(ratioX != 0) {
				w.x /= ratioX;
				w.hx1 /= ratioX;
				w.hx2 /= ratioX;
			}
			w.y -= minY;
			w.hy1 -= minY;
			w.hy2 -= minY;
			if(ratioY != 0) {
				w.y /= ratioY;
				w.hy1 /= ratioY;
				w.hy2 /= ratioY;
			}
		}
		return this;
	}
	public HPath vertex(float pxX, float pxY) {
		if(_height == 0 || _width == 0) {
			HWarnings.warn("Division by 0", "HPath.vertex()",
					HWarnings.VERTEXPX_ERR);
		} else {
			vertexPerc(pxX/_width, pxY/_height);
		}
		return this;
	}
	public HPath vertex(
		float handlePxX1, float handlePxY1,
		float handlePxX2, float handlePxY2,
		float pxX, float pxY
	) {
		if(_height == 0 || _width == 0) {
			HWarnings.warn("Division by 0", "HPath.vertex()",
					HWarnings.VERTEXPX_ERR);
		} else {
			vertexPerc(
				handlePxX1/_width, handlePxY1/_height,
				handlePxX2/_width, handlePxY2/_height,
				pxX/_width, pxY/_height);
		}
		return this;
	}
	public HPath vertexPerc(float percX, float percY) {
		HVertex v = new HVertex();
		v.x = HMath.round512(percX);
		v.y = HMath.round512(percY);
		_vertices.add(v);
		return this;
	}
	public HPath vertexPerc(
		float handlePercX1, float handlePercY1,
		float handlePercX2, float handlePercY2,
		float percX, float percY
	) {
		HVertex v = new HVertex();
		v.isBezier = true;
		v.x = HMath.round512(percX);
		v.y = HMath.round512(percY);
		v.hx1 = HMath.round512(handlePercX1);
		v.hy1 = HMath.round512(handlePercY1);
		v.hx2 = HMath.round512(handlePercX2);
		v.hy2 = HMath.round512(handlePercY2);
		_vertices.add(v);
		return this;
	}
	public HPath triangle(int type, int direction) {
		_vertices.clear();
		float ratio = 1;
		switch(type) {
		case HConstants.EQUILATERAL:
			ratio = (float)Math.sin(PConstants.TWO_PI/6);
			break;
		case HConstants.RIGHT:
			ratio = (float)Math.sin(PConstants.TWO_PI/8) / HConstants.SQRT2;
			break;
		}
		switch(direction) {
		case HConstants.TOP:
		case HConstants.CENTER_TOP:
			vertexPerc(0.5f, 0);
			vertexPerc(0, 1);
			vertexPerc(1, 1);
			height(_width*ratio);
			break;
		case HConstants.BOTTOM:
		case HConstants.CENTER_BOTTOM:
			vertexPerc(0.5f, 1);
			vertexPerc(1, 0);
			vertexPerc(0, 0);
			height(_width*ratio);
			break;
		case HConstants.RIGHT:
		case HConstants.CENTER_RIGHT:
			vertexPerc(1, 0.5f);
			vertexPerc(0, 0);
			vertexPerc(0, 1);
			width(_height*ratio);
			break;
		case HConstants.LEFT:
		case HConstants.CENTER_LEFT:
			vertexPerc(0, 0.5f);
			vertexPerc(1, 1);
			vertexPerc(1, 0);
			width(_height*ratio);
			break;
		case HConstants.TOP_LEFT:
			vertexPerc(0, 0);
			vertexPerc(0, 1);
			vertexPerc(1, 0);
			break;
		case HConstants.TOP_RIGHT:
			vertexPerc(1, 0);
			vertexPerc(0, 0);
			vertexPerc(1, 1);
			break;
		case HConstants.BOTTOM_RIGHT:
			vertexPerc(1, 1);
			vertexPerc(0, 1);
			vertexPerc(1, 0);
			break;
		case HConstants.BOTTOM_LEFT:
			vertexPerc(0, 1);
			vertexPerc(0, 0);
			vertexPerc(1, 1);
			break;
		}
		_mode = PConstants.POLYGON;
		if(type == HConstants.EQUILATERAL || type == HConstants.RIGHT) {
			proportional(true);
		}
		return this;
	}
	public HPath polygon(int numEdges) {
		_vertices.clear();
		float radInc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = radInc * i;
			vertexPerc(
				0.5f + 0.5f*(float)Math.cos(rad),
				0.5f + 0.5f*(float)Math.sin(rad));
		}
		_mode = PConstants.POLYGON;
		return this;
	}
	public HPath polygon(int numEdges, float startDeg) {
		return polygonRad(numEdges, startDeg * HConstants.D2R);
	}
	public HPath polygonRad(int numEdges, float startRad) {
		_vertices.clear();
		float radInc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = startRad + radInc*i;
			vertexPerc(
				0.5f + 0.5f*(float)Math.cos(rad),
				0.5f + 0.5f*(float)Math.sin(rad));
		}
		_mode = PConstants.POLYGON;
		return this;
	}
	public HPath star(int numEdges, float depth) {
		return starRad(numEdges, depth, 0);
	}
	public HPath star(int numEdges, float depth, float startDeg) {
		return starRad(numEdges, depth, startDeg*HConstants.D2R);
	}
	public HPath starRad(int numEdges, float depth, float startRad) {
		_vertices.clear();
		float radInc = PConstants.TWO_PI / numEdges;
		float idepth = 1 - depth;
		for(int i=0; i<numEdges; ++i) {
			float rad = startRad + radInc*i;
			vertexPerc(
				0.5f + 0.5f*(float)Math.cos(rad),
				0.5f + 0.5f*(float)Math.sin(rad));
			rad = startRad + radInc*(i + 0.5f);
			vertexPerc(
				0.5f + 0.5f*idepth*(float)Math.cos(rad),
				0.5f + 0.5f*idepth*(float)Math.sin(rad));
		}
		_mode = PConstants.POLYGON;
		return this;
	}
	public HPath clear() {
		_vertices.clear();
		return this;
	}
	public boolean containsRel(float relX, float relY) {
		boolean isIn = false;
		float xPerc = HMath.round512(relX/_width);
		float yPerc = HMath.round512(relY/_height);
		float currX = 0;
		for(int i=0; i<numVertices(); ++i) {
			HVertex v1 = _vertices.get(i);
			HVertex v2 = _vertices.get((i>=numVertices()-1)? 0 : i+1);
			if(v2.isBezier) {
				float[] params = new float[3];
				int numParams = HMath.bezierParam(
					v1.y, v2.hy1, v2.hy2, v2.y, yPerc, params);
				for(int j=0; j<numParams; ++j) {
					currX = H.app().bezierPoint(
						v1.x,v2.hx1,v2.hx2,v2.x, params[j]);
					if(currX == xPerc) return true;
					if(currX < xPerc) isIn = !isIn;
				}
			} else {
				float t = (yPerc-v1.y) / (v2.y-v1.y);
				if(0<=t && t<=1) {
					currX = v1.x + (v2.x-v1.x)*t;
					if(currX == xPerc) return true;
					if(currX < xPerc) isIn = !isIn;
				}
			}
		}
		return isIn;
	}
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float currAlphaPerc
	) {
		int numVertices = _vertices.size();
		if(numVertices <= 0) return;
		applyStyle(g,currAlphaPerc);
		if(_mode == PConstants.POINTS) g.beginShape(PConstants.POINTS);
		else g.beginShape();
		boolean startFlag = true;
		for(int i=0; i<numVertices; ++i) {
			HVertex v = _vertices.get(i);
			float x = drawX + _width*v.x;
			float y = drawY + _height*v.y;
			if(!v.isBezier || _mode == PConstants.POINTS || startFlag) {
				g.vertex(x,y);
			} else {
				float hx1 = drawX + _width * v.hx1;
				float hy1 = drawY + _height* v.hy1;
				float hx2 = drawX + _width * v.hx2;
				float hy2 = drawY + _height* v.hy2;
				g.bezierVertex(hx1,hy1, hx2,hy2, x,y);
			}
			if(startFlag) startFlag = false;
			else if(i==0) break;
			if(_mode==PConstants.POLYGON && i>=numVertices-1) i = -1;
		}
		if(_mode == PConstants.POLYGON) g.endShape(PConstants.CLOSE);
		else g.endShape();
	}
	public static class HVertex {
		public float x, y, hx1, hy1, hx2, hy2;
		public boolean isBezier;
	}
}
