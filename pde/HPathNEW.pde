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
public static class HPathNEW extends HDrawable {
	private ArrayList<HVertexNEW> _vertices;
	private int _mode;
	private boolean _drawHandles;
	public HPathNEW() {
		this(PConstants.PATH);
	}
	public HPathNEW(int pathMode) {
		_mode = pathMode;
		_vertices = new ArrayList<HVertexNEW>();
	}
	public HPathNEW createCopy() {
		HPathNEW copy = new HPathNEW();
		copy.copyPropertiesFrom(this);
		copy._mode = _mode;
		copy._drawHandles = _drawHandles;
		return copy;
	}
	public HPathNEW mode(int modeId) {
		_mode = modeId;
		return this;
	}
	public int mode() {
		return _mode;
	}
	public HPathNEW drawsHandles(boolean b) {
		_drawHandles = b;
		return this;
	}
	public boolean drawsHandles() {
		return _drawHandles;
	}
	public int numVertices() {
		return _vertices.size();
	}
	public HVertexNEW vertex(int index) {
		return _vertices.get(index);
	}
	public HPathNEW vertex(float x, float y) {
		_vertices.add(new HVertexNEW(this).set(x,y));
		return this;
	}
	public HPathNEW vertex(float cx, float cy, float x, float y) {
		_vertices.add(new HVertexNEW(this).set(cx,cy, x,y));
		return this;
	}
	public HPathNEW vertex(
		float cx1, float cy1,
		float cx2, float cy2,
		float x, float y
	) {
		_vertices.add(new HVertexNEW(this).set(cx1,cy1, cx2,cy2, x,y));
		return this;
	}
	public HPathNEW vertexUV(float u, float v) {
		_vertices.add(new HVertexNEW(this).setUV(u,v));
		return this;
	}
	public HPathNEW vertexUV(float cu, float cv, float u, float v) {
		_vertices.add(new HVertexNEW(this).setUV(cu,cv, u,v));
		return this;
	}
	public HPathNEW vertexUV(
		float cu1, float cv1,
		float cu2, float cv2,
		float u, float v
	) {
		_vertices.add(new HVertexNEW(this).setUV(cu1,cv1, cu2,cv2, u,v));
		return this;
	}
	public HPathNEW adjust() {
		int numv = numVertices();
		float[] minmax = new float[4];
		for(int i=0; i<numv; ++i) vertex(i).computeMinMax(minmax);
		float scaleW = minmax[2] - minmax[0];
		float scaleH = minmax[3] - minmax[1];
		float offU = -minmax[0];
		float offV = -minmax[1];
		for(int i=0; i<numv; ++i) vertex(i).adjust(offU,offV, scaleW,scaleH);
		float ancU = (scaleW==0? offU : offU/scaleW);
		float ancV = (scaleH==0? offV : offV/scaleH);
		scale(scaleW,scaleH).anchorPerc(ancU,ancV);
		return this;
	}
	public HPathNEW endPath() {
		return adjust();
	}
	public HPathNEW clear() {
		_vertices.clear();
		return this;
	}
	public HPathNEW triangle(int type, int direction) {
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
	public HPathNEW polygon(int numEdges) {
		return polygonRad(numEdges, 0);
	}
	public HPathNEW polygon(int numEdges, float startDeg) {
		return polygonRad(numEdges, startDeg*HConstants.D2R);
	}
	public HPathNEW polygonRad(int numEdges, float startRad) {
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
	public HPathNEW star(int numEdges, float depth) {
		return starRad(numEdges, depth, 0);
	}
	public HPathNEW star(int numEdges, float depth, float startDeg) {
		return starRad(numEdges, depth, startDeg*HConstants.D2R);
	}
	public HPathNEW starRad(int numEdges, float depth, float startRad) {
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
	public boolean containsRel(float relX, float relY) {
		if(numVertices() <= 0) return false;
		relX /= _width;
		relY /= _height;
		int numCrossings = 0;
		int numv = numVertices();
		HVertexNEW lastVtx = vertex(numv-1);
		for(int i=0; i<numv; ++i) {
			HVertexNEW v = vertex(i);
			int tmp = v.getCrossings(lastVtx, relX, relY);
			if(tmp<0) return true;
			numCrossings += tmp;
			lastVtx = v;
		}
		return (numCrossings&1) == 1;
	}
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float alphaPc
	) {
		int numv = numVertices();
		if(numv <= 0) return;
		applyStyle(g, alphaPc);
		boolean isPoints = (_mode == PConstants.POINTS);
		boolean isPolygon = (_mode == PConstants.POLYGON);
		boolean isFirst = true;
		if(isPoints) g.beginShape(PConstants.POINTS);
		else g.beginShape();
		int itrs = (isPolygon)? numv+1 : numv;
		for(int i=0; i<itrs; ++i) {
			vertex(i<numv? i : 0).draw(g, isFirst || isPoints, _drawHandles);
			if(isFirst) isFirst = false;
		}
		if(isPolygon) g.endShape(PConstants.CLOSE);
		else g.endShape();
	}
}
