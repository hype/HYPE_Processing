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
import hype.core.util.HColors;
import hype.core.util.HConstants;
import hype.extended.util.HVertex;

import java.util.ArrayList;

import processing.core.PConstants;
import processing.core.PGraphics;

public class HPath extends HDrawable {
	private ArrayList<HVertex> _vertices;
	private int _mode;
	private boolean _drawsHandles;
	
	public HPath() {
		this(PConstants.PATH);
	}
	
	public HPath(int modeId) {
		_mode = modeId;
		_vertices = new ArrayList<HVertex>();
	}
	
	@Override
	public HPath createCopy() {
		HPath copy = new HPath(_mode);
		copy.copyPropertiesFrom(this);
		copy._drawsHandles = _drawsHandles;
		for(int i=0; i<numVertices(); ++i) {
			copy._vertices.add(vertex(i).createCopy(copy));
		}
		return copy;
	}
	
	public HPath mode(int modeId) {
		_mode = modeId;
		return this;
	}
	
	public int mode() {
		return _mode;
	}
	
	public HPath drawsHandles(boolean b) {
		_drawsHandles = b;
		return this;
	}
	
	public boolean drawsHandles() {
		return _drawsHandles;
	}
	
	public int numVertices() {
		return _vertices.size();
	}
	
	public HVertex vertex(int index) {
		return _vertices.get(index);
	}
	
	public HPath vertex(float x, float y) {
		_vertices.add(new HVertex(this).set(x,y));
		return this;
	}
	
	public HPath vertex(float cx, float cy, float x, float y) {
		_vertices.add(new HVertex(this).set(cx,cy, x,y));
		return this;
	}
	
	public HPath vertex(
		float cx1, float cy1,
		float cx2, float cy2,
		float x, float y
	) {
		_vertices.add(new HVertex(this).set(cx1,cy1, cx2,cy2, x,y));
		return this;
	}
	
	public HPath vertexUV(float u, float v) {
		_vertices.add(new HVertex(this).setUV(u,v));
		return this;
	}
	
	public HPath vertexUV(float cu, float cv, float u, float v) {
		_vertices.add(new HVertex(this).setUV(cu,cv, u,v));
		return this;
	}
	
	public HPath vertexUV(
		float cu1, float cv1,
		float cu2, float cv2,
		float u, float v
	) {
		_vertices.add(new HVertex(this).setUV(cu1,cv1, cu2,cv2, u,v));
		return this;
	}
	
	public HPath adjust() {
		int numv = numVertices();
		float[] minmax = new float[4];
		
		for(int i=0; i<numv; ++i) vertex(i).computeMinMax(minmax);
		float scaleW = minmax[2] - minmax[0];
		float scaleH = minmax[3] - minmax[1];
		float offU = _anchorPercX - minmax[0];
		float offV = _anchorPercY - minmax[1];
		for(int i=0; i<numv; ++i) vertex(i).adjust(offU,offV, scaleW,scaleH);
		
		float ancU = (scaleW==0? offU : offU/scaleW);
		float ancV = (scaleH==0? offV : offV/scaleH);
		scale(scaleW,scaleH).anchorPerc(ancU,ancV);
		return this;
	}
	
	public HPath endPath() {
		return adjust();
	}
	
	public HPath reset() {
		size(DEFAULT_WIDTH,DEFAULT_HEIGHT).anchorPerc(0,0);
		return clear();
	}
	
	public HPath startPath(int modeId) {
		return reset().mode(modeId);
	}
	
	public HPath startPath() {
		return reset();
	}
	
	public HPath clear() {
		_vertices.clear();
		return this;
	}
	
	public HPath line(float x1, float y1, float x2, float y2) {
		return clear().vertex(x1,y1).vertex(x2,y2).endPath();
	}
	
	public HPath lineUV(float u1, float v1, float u2, float v2) {
		return clear().vertexUV(u1,v1).vertexUV(u2,v2).endPath();
	}

	public HPath triangle(int type, int direction) {
		clear();
		_mode = PConstants.POLYGON;
		
		float ratio = 2;
		switch(type) {
		case HConstants.EQUILATERAL:
			ratio = (float) Math.sin(PConstants.TWO_PI/6);
			break;
		case HConstants.RIGHT:
			ratio = (float) Math.sin(PConstants.TWO_PI/8)/HConstants.SQRT2;
			break;
		}
		
		switch(direction) {
		case HConstants.TOP: case HConstants.CENTER_TOP:
			vertexUV(.5f,0).vertexUV(0,1).vertexUV(1,1);
			if(ratio < 2) height(_width*ratio).proportional(true);
			break;
		case HConstants.BOTTOM: case HConstants.CENTER_BOTTOM:
			vertexUV(.5f,1).vertexUV(1,0).vertexUV(0,0);
			if(ratio < 2) height(_width*ratio).proportional(true);
			break;
		case HConstants.RIGHT: case HConstants.CENTER_RIGHT:
			vertexUV(1,.5f).vertexUV(0,0).vertexUV(0,1);
			if(ratio < 2) width(_height*ratio).proportional(true);
			break;
		case HConstants.LEFT: case HConstants.CENTER_LEFT:
			vertexUV(0,.5f).vertexUV(1,1).vertexUV(1,0);
			if(ratio < 2) width(_height*ratio).proportional(true);
			break;
		case HConstants.TOP_LEFT:
			vertexUV(0,0).vertexUV(0,1).vertexUV(1,0); break;
		case HConstants.TOP_RIGHT:
			vertexUV(1,0).vertexUV(0,0).vertexUV(1,1); break;
		case HConstants.BOTTOM_RIGHT:
			vertexUV(1,1).vertexUV(0,1).vertexUV(1,0); break;
		case HConstants.BOTTOM_LEFT:
			vertexUV(0,1).vertexUV(0,0).vertexUV(1,1); break;
		}
		return this;
	}
	
	public HPath polygon(int numEdges) {
		return polygonRad(numEdges, 0);
	}
	
	public HPath polygon(int numEdges, float startDeg) {
		return polygonRad(numEdges, startDeg*HConstants.D2R);
	}
	
	public HPath polygonRad(int numEdges, float startRad) {
		clear();
		_mode = PConstants.POLYGON;
		
		float inc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = startRad + inc*i;
			vertexUV(
				0.5f + 0.5f*(float)Math.cos(rad),
				0.5f + 0.5f*(float)Math.sin(rad));
		}
		return this;
	}
	
	public HPath star(int numEdges, float depth) {
		return starRad(numEdges, depth, 0);
	}
	
	public HPath star(int numEdges, float depth, float startDeg) {
		return starRad(numEdges, depth, startDeg*HConstants.D2R);
	}
	
	public HPath starRad(int numEdges, float depth, float startRad) {
		clear();
		_mode = PConstants.POLYGON;
		
		float inc = PConstants.TWO_PI / numEdges;
		float idepth2 = (1-depth) * 0.5f;
		for(int i=0; i<numEdges; ++i) {
			float rad = startRad + inc*i;
			vertexUV(
				0.5f + 0.5f*(float)Math.cos(rad),
				0.5f + 0.5f*(float)Math.sin(rad));
			rad += inc/2;
			vertexUV(
				0.5f + idepth2*(float)Math.cos(rad),
				0.5f + idepth2*(float)Math.sin(rad));
		}
		return this;
	}
	
	@Override
	public boolean containsRel(float relX, float relY) {
		int numv = numVertices();
		
		if(numv <= 0) return false;
		if(_width==0) return (relX==0) && (0<relY && relY<_height);
		if(_height==0) return (relY==0) && (0<relX && relX<_width);
		if(!super.containsRel(relX,relY)) return false;
		
		float u = relX / _width;
		float v = relY / _height;
		boolean openPath = false;
		
		switch(_mode) {
		case PConstants.POINTS:
			for(int i=0; i<numv; ++i) {
				HVertex curr = vertex(i);
				if(curr.u()==u && curr.v()==v) return true;
			}
			return false;
		case PConstants.PATH:
			openPath = true;
			if(HColors.isTransparent(_fill)) {
				HVertex prev = vertex(openPath? 0 : numv-1);
				for(int i=(openPath? 1 : 0); i<numv; ++i) {
					HVertex curr = vertex(i);
					if(curr.inLine(prev, u,v)) return true;
					prev = curr;
					if(openPath) openPath = false;
				}
				return false;
			}
		default:
			boolean isIn = false;
			HVertex prev = vertex(numv-1);
			HVertex pprev = vertex(numv>1? numv-2 : 0);
			
			for(int i=0; i<numv; ++i) {
				HVertex curr = vertex(i);
				if(curr.intersectTest(pprev,prev, u,v, openPath)) isIn = !isIn;
				pprev = prev;
				prev = curr;
				if(openPath) openPath = false;
			}
			return isIn;
		}
	}

	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float alphaPc
	) {
		int numv = numVertices();
		if(numv <= 0) return;
		applyStyle(g, alphaPc);
		
		boolean drawsLines = (_mode != PConstants.POINTS);
		boolean isPolygon = (_mode==PConstants.POLYGON && numv>2);
		boolean isSimple = true;
		
		if(drawsLines) g.beginShape();
		else g.beginShape(PConstants.POINTS);
		
		int itrs = (isPolygon)? numv+1 : numv;
		for(int i=0; i<itrs; ++i) {
			HVertex v = vertex(i<numv? i : 0);
			v.draw(g, drawX, drawY, isSimple);
			if(isSimple && drawsLines) isSimple = false;
		}
		
		if(isPolygon) g.endShape(PConstants.CLOSE);
		else g.endShape();
	}
}
