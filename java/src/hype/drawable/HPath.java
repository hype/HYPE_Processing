package hype.drawable;

import hype.util.H;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PConstants;

public class HPath extends HDrawable {
	protected ArrayList<HVertex> _vertices;
	protected int _mode;
	
	public HPath() {
		this(PConstants.PATH);
	}
	
	public HPath(int pathMode) {
		_vertices = new ArrayList<HPath.HVertex>();
		_mode = pathMode;
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
	
	public HPath adjustVertices() {
		int numVertices = _vertices.size();
		HVertex v = _vertices.get(0);
		float minX = v.x;
		float maxX = v.y;
		float minY = v.x;
		float maxY = v.y;
		
		for(int i=1; i<numVertices; ++i) {
			v = _vertices.get(i);
			if(v.x < minX) minX = v.x;
			else if(v.x > maxX) maxX = v.x;
			
			if(v.y < minY) minY = v.y;
			else if(v.y > maxY) maxY = v.y;
		}
		
		float ratioX = maxX - minX;
		float ratioY = maxY - minY;
		
		scale(ratioX, ratioY);
		
		anchorPercX((ratioX==0)? -minX : -minX/ratioX);
		anchorPercY((ratioY==0)? -minY : -minY/ratioY);
		
		for(int j=0; j<numVertices; ++j) {
			v = _vertices.get(j);
			
			v.x -= minX;
			v.handleX1 -= minX;
			v.handleX2 -= minX;
			if(ratioX != 0) {
				v.x /= ratioX;
				v.handleX1 /= ratioX;
				v.handleX2 /= ratioX;
			}
			
			v.y -= minY;
			v.handleY1 -= minY;
			v.handleY2 -= minY;
			if(ratioY != 0) {
				v.y /= ratioY;
				v.handleY1 /= ratioY;
				v.handleY2 /= ratioY;
			}
		}
		return this;
	}
	
	public HPath vertex(float pxX, float pxY) {
		if(_height == 0 || _width == 0) {
			H.warn("Division by 0", "HPath.vertex()",
				"Size must be greater than 0 before adding vertices by pixel " +
				"Set the size for this path first, or add vertices by " +
				"percentage via vertexPerc() instead");
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
			H.warn("Division by 0", "HPath.vertex()",
				"Size must be greater than 0 before adding vertices by pixel " +
				"Set the size for this path first, or add vertices by " +
				"percentage via vertexPerc() instead");
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
		v.x = v.handleX1 = v.handleX2 = percX;
		v.y = v.handleY1 = v.handleY2 = percY;
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
		v.handleX1 = handlePercX1;
		v.handleY1 = handlePercY1;
		v.handleX2 = handlePercX2;
		v.handleY2 = handlePercY2;
		_vertices.add(v);
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
	
	@SuppressWarnings("static-access")
	public HPath star(int numEdges, float depth) {
		_vertices.clear();
		PApplet app = H.app();
		
		float radInc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = radInc * i;
			vertexPerc(
				0.5f + 0.5f*app.cos(rad),
				0.5f + 0.5f*app.sin(rad));
			
			rad = radInc * (i + 0.5f);
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
	public HPath createCopy() {
		HPath copy = new HPath();
		copy.copyPropertiesFrom(this);
		for(int i=0; i<_vertices.size(); ++i) {
			HVertex v = _vertices.get(i);
			copy.vertexPerc(v.x, v.y,
				v.handleX1, v.handleY1,
				v.handleX2, v.handleY2);
		}
		return copy;
	}
	
	@Override
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {
		int numVertices = _vertices.size();
		if(numVertices <= 0) return;
		
		applyStyle(app,currAlphaPerc);
		
		// Begin Shape
		if(_mode == PConstants.POINTS) app.beginShape(PConstants.POINTS);
		else app.beginShape();
		
		// Draw the vertices
		boolean startFlag = true;
		for(int i=0; i<numVertices; ++i) {
			HVertex v = _vertices.get(i);
			float x = drawX + _width*v.x;
			float y = drawY + _height*v.y;
			if(!v.isBezier || _mode == PConstants.POINTS || startFlag) {
				app.vertex(x,y);
			} else {
				float hx1 = drawX + _width*v.handleX1;
				float hy1 = drawY + _height*v.handleY1;
				float hx2 = drawX + _width*v.handleX2;
				float hy2 = drawY + _height*v.handleY2;
				app.bezierVertex(hx1,hy1, hx2,hy2, x,y);
			}
			
			// Set startFlag to false once the first iteration is finished 
			if(startFlag) startFlag = false;
			// End the loop if this is the second time that i is equals to 0
			else if(i==0) break;
			
			// Go back to the first vertex for its bezier curve
			if(_mode==PConstants.POLYGON && i==numVertices-1) i = -1;
		}
		
		// End Shape
		if(_mode == PConstants.POLYGON) app.endShape(PConstants.CLOSE);
		else app.endShape();
	}
	
	public static class HVertex {
		public float x, y, handleX1, handleY1, handleX2, handleY2;
		public boolean isBezier;
	}
}
