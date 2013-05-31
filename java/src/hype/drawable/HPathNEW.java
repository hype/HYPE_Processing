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

package hype.drawable;

import hype.util.HConstants;
import hype.util.HVertexNEW;

import java.util.ArrayList;

import processing.core.PConstants;
import processing.core.PGraphics;

public class HPathNEW extends HDrawable {
	private ArrayList<HVertexNEW> _vtcs;
	private int _mode;
	
	
	// CONSTRUCTORS & COPYING //
	
	public HPathNEW() {
		this(PConstants.PATH);
	}
	
	public HPathNEW(int pathMode) {
		_vtcs = new ArrayList<HVertexNEW>();
		_mode = pathMode;
	}
	
	@Override
	public HDrawable createCopy() {
		HPathNEW copy = new HPathNEW(_mode);
		copy.copyPropertiesFrom(this);
		for(int i=0; i<_vtcs.size(); ++i) copy._vtcs.add(_vtcs.get(i));
		return copy;
	}
	
	
	// MODE //

	public HPathNEW mode(int m) {
		_mode = m;
		return this;
	}

	public int mode() {
		return _mode;
	}
	
	
	// VERTICES //

	public int numVertices() {
		return _vtcs.size();
	}
	
	public HVertexNEW vertex(int index) {
		return _vtcs.get(index);
	}
	
	public HPathNEW vertex(float xpx, float ypx) {
		_vtcs.add(new HVertexNEW(this).set(xpx,ypx));
		return this;
	}
	
	public HPathNEW vertex(float cx, float cy, float xpx, float ypx) {
		_vtcs.add(new HVertexNEW(this).set(cx,cy, xpx,ypx));
		return this;
	}
	
	public HPathNEW vertex(
		float cx1, float cy1,  float cx2, float cy2,
		float xpx, float ypx
	) {
		_vtcs.add(new HVertexNEW(this).set(cx1,cy1, cx2,cy2, xpx,ypx));
		return this;
	}

	public HPathNEW vertexUV(float xpc, float ypc) {
		_vtcs.add(new HVertexNEW(this).setUV(xpc,ypc));
		return this;
	}
	
	public HPathNEW vertexUV(float cx, float cy, float xpx, float ypx) {
		_vtcs.add(new HVertexNEW(this).setUV(cx,cy, xpx,ypx));
		return this;
	}
	
	public HPathNEW vertexUV(
		float cx1, float cy1,  float cx2, float cy2,
		float xpx, float ypx
	) {
		_vtcs.add(new HVertexNEW(this).setUV(cx1,cy1, cx2,cy2, xpx,ypx));
		return this;
	}
	
	public HPathNEW clear() {
		_vtcs.clear();
		return this;
	}
	
	public HPathNEW endPath() {
		int numVtcs = _vtcs.size();
		float[] minmax = new float[4];
		
		for(int i=0; i<numVtcs; ++i) _vtcs.get(i).computeMinMax(minmax);
		
		float minx = minmax[0];
		float miny = minmax[1];
		float wpc = minmax[2] - minx;
		float hpc = minmax[3] - miny;
		scale(wpc,hpc);
		anchorPerc((wpc==0? 0 : -minx/wpc), (hpc==0? 0 : -miny/wpc));
		
		for(int i=0; i<numVtcs; ++i) _vtcs.get(i).adjust(minx,miny,wpc,hpc);
		
		return this;
	}
	
	
	// UTILS //
	
	public HPathNEW triangle(int type, int direction) {
		_vtcs.clear();
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
	
	public HPathNEW polygon(int numEdges) {
		return polygonRad(numEdges, 0);
	}
	
	public HPathNEW polygon(int numEdges, float startDeg) {
		return polygonRad(numEdges, startDeg*HConstants.D2R);
	}
	
	public HPathNEW polygonRad(int numEdges, float startRad) {
		_vtcs.clear();
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
	
	public HPathNEW star(int numEdges, float depth) {
		return starRad(numEdges, depth, 0);
	}
	
	public HPathNEW star(int numEdges, float depth, float startDeg) {
		return starRad(numEdges, depth, startDeg*HConstants.D2R);
	}
	
	public HPathNEW starRad(int numEdges, float depth, float startRad) {
		_vtcs.clear();
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
	
	
	// MISC //
	
	@Override
	public boolean containsRel(float relX, float relY) {
//		int numCrossings = 0;
//		int numVtcs = _vtcs.size();
//		HVertexNEW lastVtx = _vtcs.get(numVtcs-1);
//		// FIXME
//		for(int i=0; i<numVtcs; ++i) {
//			HVertexNEW v = _vtcs.get(i);
//			int tmp = v.getCrossings(lastVtx, relX, relY);
//			
//			if(tmp<0) return true;
//			
//			numCrossings += tmp;
//			lastVtx = v;
//		}
//		return (numCrossings&1) == 1;
		return false; // TODO
	}
	
	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float currAlphaPerc
	) {
		int numVtcs = _vtcs.size();
		if(numVtcs <= 0) return;
		
		applyStyle(g,currAlphaPerc);
		
		boolean hasLines = (_mode != PConstants.POINTS);
		boolean isPolygon = (_mode == PConstants.POLYGON);
		boolean isFirst = true;
		
		if(hasLines) g.beginShape();
		else g.beginShape(PConstants.POINTS);
		
		int itrs = (isPolygon)? numVtcs+1 : numVtcs;
		for(int i=0; i<itrs; ++i) {
			HVertexNEW v = _vtcs.get(i<numVtcs? i : 0);
			v.draw( g, isFirst && hasLines );
			if(isFirst) isFirst = false;
		}
		if(isPolygon) g.endShape(PConstants.CLOSE);
		else g.endShape();
	}
}
