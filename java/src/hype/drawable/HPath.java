package hype.drawable;

import hype.util.H;
import hype.util.HConstants;
import hype.util.HWarnings;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PGraphics;

public class HPath extends HDrawable {
	protected ArrayList<HVertex> _vertices;
	protected int _mode;
	protected boolean _preserveSizeRatio;
	
	public HPath() {
		this(PConstants.PATH);
	}
	
	public HPath(int pathMode) {
		_vertices = new ArrayList<HPath.HVertex>();
		_mode = pathMode;
	}
	
	@Override
	public HPath createCopy() {
		HPath copy = new HPath();
		copy.copyPropertiesFrom(this);
		for(int i=0; i<_vertices.size(); ++i) {
			HVertex v = _vertices.get(i);
			copy.vertexPerc(v.x, v.y,
				v.hx1, v.hy1,
				v.hx2, v.hy2);
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
		v.x = v.hx1 = v.hx2 = percX;
		v.y = v.hy1 = v.hy2 = percY;
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
		v.x = percX;
		v.y = percY;
		v.hx1 = handlePercX1;
		v.hy1 = handlePercY1;
		v.hx2 = handlePercX2;
		v.hy2 = handlePercY2;
		_vertices.add(v);
		return this;
	}
	
	public HPath preserveSizeRatio(boolean b) {
		_preserveSizeRatio = b;
		return this;
	}
	
	public boolean preserveSizeRatio() {
		return _preserveSizeRatio;
	}
	
	@Override
	public HPath width(float w) {
		if(_preserveSizeRatio) {
			float ratio = _height / _width;
			_height = ratio * w;
		}
		return (HPath) super.width(w);
	}
	
	@Override
	public HPath height(float h) {
		if(_preserveSizeRatio) {
			float ratio = _width / _height;
			_width = ratio * h;
		}
		return (HPath) super.height(h);
	}
	
	public HPath triangle(int type, int direction) {
		_vertices.clear();
		
		@SuppressWarnings("static-access")
		float eqRatio = (type == HConstants.EQUILATERAL)?
			H.app().sin(PConstants.TWO_PI/6) : 1;
		
		switch(direction) {
		case HConstants.TOP:
		case HConstants.CENTER_TOP:
			vertexPerc(0.5f, 0);
			vertexPerc(0, 1);
			vertexPerc(1, 1);
			scale(1,eqRatio);
			break;
		case HConstants.BOTTOM:
		case HConstants.CENTER_BOTTOM:
			vertexPerc(0.5f, 1);
			vertexPerc(1, 0);
			vertexPerc(0, 0);
			scale(1,eqRatio);
			break;
		case HConstants.RIGHT:
		case HConstants.CENTER_RIGHT:
			vertexPerc(1, 0.5f);
			vertexPerc(0, 0);
			vertexPerc(0, 1);
			scale(eqRatio,1);
			break;
		case HConstants.LEFT:
		case HConstants.CENTER_LEFT:
			vertexPerc(0, 0.5f);
			vertexPerc(1, 1);
			vertexPerc(1, 0);
			scale(eqRatio,1);
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
		if(type == HConstants.EQUILATERAL) _preserveSizeRatio = true;
		return this;
	}
	
	@SuppressWarnings("static-access")
	public HPath polygon(int numEdges) {
		_vertices.clear();
		PApplet app = H.app();
		
		float radInc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = radInc * i;
			vertexPerc(
				0.5f + 0.5f*app.cos(rad),
				0.5f + 0.5f*app.sin(rad));
		}
		_mode = PConstants.POLYGON;
		return this;
	}
	
	public HPath polygon(int numEdges, float startDeg) {
		return polygonRad(numEdges, startDeg * HConstants.D2R);
	}
	
	@SuppressWarnings("static-access")
	public HPath polygonRad(int numEdges, float startRad) {
		_vertices.clear();
		PApplet app = H.app();
		
		float radInc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = startRad + radInc*i;
			vertexPerc(
				0.5f + 0.5f*app.cos(rad),
				0.5f + 0.5f*app.sin(rad));
		}
		_mode = PConstants.POLYGON;
		return this;
	}
	
	public HPath star(int numEdges, float depth) {
		return starRad(numEdges, depth, 0);
	}
	
	public HPath star(int numEdges, float depth, float startDeg) {
		return starRad(numEdges, depth, startDeg * HConstants.D2R);
	}
	
	@SuppressWarnings("static-access")
	public HPath starRad(int numEdges, float depth, float startRad) {
		_vertices.clear();
		PApplet app = H.app();
		
		float radInc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = startRad + radInc*i;
			vertexPerc(
				0.5f + 0.5f*app.cos(rad),
				0.5f + 0.5f*app.sin(rad));
			
			rad = startRad + radInc*(i + 0.5f);
			vertexPerc(
				0.5f + 0.5f*app.cos(rad)*(1-depth),
				0.5f + 0.5f*app.sin(rad)*(1-depth));
		}
		_mode = PConstants.POLYGON;
		return this;
	}
	
	public HPath clear() {
		_vertices.clear();
		return this;
	}
	
	@Override
	public boolean containsRel(float relX, float relY) {
		boolean isIn = false;
		float xPerc = relX / _width;
		float yPerc = relY / _height;
		
		for(int i=0; i<numVertices(); ++i) {
			HVertex v1 = _vertices.get(i);
			HVertex v2 = _vertices.get((i>=numVertices()-1)? 0 : i+1);
			
			float t = (yPerc-v1.y) / (v2.y-v1.y);
			if(0<t && t<=1) {
				float currX = v1.x + (v2.x-v1.x)*t;
				
				if(currX == xPerc) return true;
				if(currX < xPerc) isIn = !isIn;
			}
		}
		return isIn;
		
		// TODO checking for the bezier stuff
	}
	
	@Override
	public void draw(PGraphics g,float drawX,float drawY,float currAlphaPerc) {
		int numVertices = _vertices.size();
		if(numVertices <= 0) return;
		
		applyStyle(g,currAlphaPerc);
		
		// Begin Shape
		if(_mode == PConstants.POINTS) g.beginShape(PConstants.POINTS);
		else g.beginShape();
		
		// Draw the vertices
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
			
			// Set startFlag to false once the first iteration is finished 
			if(startFlag) startFlag = false;
			// End the loop if this is the second time that i is equals to 0
			else if(i==0) break;
			
			// Go back to the first vertex for its bezier curve
			if(_mode==PConstants.POLYGON && i>=numVertices-1) i = -1;
		}
		
		// End Shape
		if(_mode == PConstants.POLYGON) g.endShape(PConstants.CLOSE);
		else g.endShape();
	}
	
	public static class HVertex {
		public float x, y, hx1, hy1, hx2, hy2;
		public boolean isBezier;
	}
}
