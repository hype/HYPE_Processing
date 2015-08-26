package hype;

import hype.interfaces.HConstants;
import processing.core.PConstants;
import processing.core.PGraphics;

import java.util.ArrayList;

public class HPath extends HDrawable {
	public static final int HANDLE_FILL = 0xFFFF0000;
	public static final int HANDLE_STROKE = 0xFF202020;
	public static final float HANDLE_STROKE_WEIGHT = 1;
	public static final float HANDLE_SIZE = 6;

	private ArrayList<HVertex> vertices;
	private int mode;
	private boolean drawsHandles;

	public HPath() {
		this(PConstants.PATH);
	}

	public HPath(int modeId) {
		mode = modeId;
		vertices = new ArrayList<HVertex>();
	}

	@Override
	public HPath createCopy() {
		HPath copy = new HPath(mode);
		copy.copyPropertiesFrom(this);
		copy.drawsHandles = drawsHandles;
		for(int i=0; i<numVertices(); ++i) {
			copy.vertices.add(vertex(i).createCopy(copy));
		}
		return copy;
	}

	public HPath mode(int modeId) {
		mode = modeId;
		return this;
	}

	public int mode() {
		return mode;
	}

	public HPath drawsHandles(boolean b) {
		drawsHandles = b;
		return this;
	}

	public boolean drawsHandles() {
		return drawsHandles;
	}

	public int numVertices() {
		return vertices.size();
	}

	public HVertex vertex(int index) {
		return vertices.get(index);
	}

	public HPath vertex(float x, float y) {
		vertices.add(new HVertex(this).set(x, y));
		return this;
	}

	public HPath vertex(float cx, float cy, float x, float y) {
		vertices.add(new HVertex(this).set(cx, cy, x, y));
		return this;
	}

	public HPath vertex(
		float cx1, float cy1,
		float cx2, float cy2,
		float x, float y
	) {
		vertices.add(new HVertex(this).set(cx1, cy1, cx2, cy2, x, y));
		return this;
	}

	public HPath vertexUV(float u, float v) {
		vertices.add(new HVertex(this).setUV(u, v));
		return this;
	}

	public HPath vertexUV(float cu, float cv, float u, float v) {
		vertices.add(new HVertex(this).setUV(cu, cv, u, v));
		return this;
	}

	public HPath vertexUV(
		float cu1, float cv1,
		float cu2, float cv2,
		float u, float v
	) {
		vertices.add(new HVertex(this).setUV(cu1, cv1, cu2, cv2, u, v));
		return this;
	}

	public HPath adjust() {
		int numv = numVertices();
		float[] minmax = new float[4];

		for(int i=0; i<numv; ++i) vertex(i).computeMinMax(minmax);

		float offU = -minmax[0],	offV = -minmax[1];
		float oldW = width,		oldH = height;
		anchorUV(offU,offV).scale(minmax[2]+offU, minmax[3]+offV);

		for(int i=0; i<numv; ++i) vertex(i).adjust(offU,offV, oldW,oldH);
		return this;
	}

	public HPath endPath() {
		return adjust();
	}

	public HPath reset() {
		size(DEFAULT_WIDTH,DEFAULT_HEIGHT).anchorUV(0,0);
		return clear();
	}

	public HPath beginPath(int modeId) {
		return reset().mode(modeId);
	}

	public HPath beginPath() {
		return reset();
	}

	public HPath clear() {
		vertices.clear();
		return this;
	}

	public HPath line(float x1, float y1, float x2, float y2) {
		return beginPath(PConstants.PATH)
				.vertex(x1,y1).vertex(x2,y2).endPath();
	}

	public HPath lineUV(float u1, float v1, float u2, float v2) {
		return beginPath(PConstants.PATH)
			.vertexUV(u1,v1).vertexUV(u2,v2).endPath();
	}

	public HPath triangle(int type, int direction) {
		clear().mode(PConstants.POLYGON);

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
			if(ratio < 2) height(width *ratio).proportional(true);
			break;
		case HConstants.BOTTOM: case HConstants.CENTER_BOTTOM:
			vertexUV(.5f,1).vertexUV(1,0).vertexUV(0,0);
			if(ratio < 2) height(width *ratio).proportional(true);
			break;
		case HConstants.RIGHT: case HConstants.CENTER_RIGHT:
			vertexUV(1,.5f).vertexUV(0,0).vertexUV(0,1);
			if(ratio < 2) width(height *ratio).proportional(true);
			break;
		case HConstants.LEFT: case HConstants.CENTER_LEFT:
			vertexUV(0,.5f).vertexUV(1,1).vertexUV(1,0);
			if(ratio < 2) width(height *ratio).proportional(true);
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
		clear().mode(PConstants.POLYGON);

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
		clear().mode(PConstants.POLYGON);

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
		if(width == 0) return (relX == 0) && (0<relY && relY< height);
		if(height == 0) return (relY == 0) && (0<relX && relX< width);
		if( !super.containsRel(relX,relY) ) return false;

		boolean openPath = false;

		switch(mode) {
		case PConstants.POINTS:
			for(int i=0; i<numv; ++i) {
				HVertex curr = vertex(i);
				if(curr.u()==relX/ width && curr.v()==relY/ height) return true;
			}
			return false;
		case PConstants.PATH:
			openPath = true;
			if(HColors.isTransparent(fill)) {
				HVertex prev = vertex(openPath? 0 : numv-1);
				for(int i=(openPath? 1 : 0); i<numv; ++i) {
					HVertex curr = vertex(i);
					if(curr.inLine(prev,relX,relY)) return true;
					prev = curr;
					if(openPath) openPath = false;
				}
				return false;
			}
		default:
			float u = relX / width; // TODO remove these, use relX,relY
			float v = relY / height; //
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

		boolean drawsLines = (mode != PConstants.POINTS);
		boolean isPolygon = (mode ==PConstants.POLYGON && numv>2);
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

		if(drawsHandles && drawsLines) {
			HVertex prev = vertex(isPolygon? numv-1 : 0);
			for(int i=(isPolygon? 0 : 1); i<numv; ++i) {
				HVertex curr = vertex(i);
				curr.drawHandles(g, prev, drawX, drawY);
				prev = curr;
			}
		}
	}
}
