package hype;

import hype.interfaces.HLocatable;
import processing.core.PGraphics;

public class HVertex implements HLocatable {
	public static final float LINE_TOLERANCE = 1.5f;

	private HPath path;
	private byte numControlPts;
	private float u, v, cu1, cv1, cu2, cv2;

	public HVertex(HPath parentPath) {
		path = parentPath;
	}

	public HVertex createCopy(HPath newParentPath) {
		HVertex copy = new HVertex(newParentPath);
		copy.numControlPts = numControlPts;
		copy.u = u;
		copy.v = v;
		copy.cu1 = cu1;
		copy.cv1 = cv1;
		copy.cu2 = cu2;
		copy.cv2 = cv2;
		return copy;
	}

	public HPath path() {
		return path;
	}

	public HVertex numControlPts(byte b) {
		numControlPts = b;
		return this;
	}

	public byte numControlPts() {
		return numControlPts;
	}

	public boolean isLine() {
		return (numControlPts <= 0);
	}

	public boolean isCurved() {
		return (numControlPts > 0);
	}

	public boolean isQuadratic() {
		return (numControlPts == 1);
	}

	public boolean isCubic() {
		return (numControlPts >= 2);
	}

	public HVertex set(float x, float y) {
		return setUV(
				path.x2u(x), path.y2v(y));
	}

	public HVertex set(float cx, float cy, float x, float y) {
		return setUV(
				path.x2u(cx), path.y2v(cy),
				path.x2u(x), path.y2v(y));
	}

	public HVertex set(
		float cx1, float cy1,
		float cx2, float cy2,
		float x, float y
	) {
		return setUV(
			path.x2u(cx1), path.y2v(cy1),
			path.x2u(cx2), path.y2v(cy2),
			path.x2u(x),   path.y2v(y));
	}

	public HVertex setUV(float u, float v) {
		numControlPts = 0;
		this.u = u;
		this.v = v;
		return this;
	}

	public HVertex setUV(float cu, float cv, float u, float v) {
		numControlPts = 1;
		this.u = u;
		this.v = v;
		cu1 = cu;
		cv1 = cv;
		return this;
	}

	public HVertex setUV(
		float cu1, float cv1,
		float cu2, float cv2,
		float u, float v
	) {
		numControlPts = 2;
		this.u = u;
		this.v = v;
		this.cu1 = cu1;
		this.cv1 = cv1;
		this.cu2 = cu2;
		this.cv2 = cv2;
		return this;
	}

	@Override
	public HVertex x(float f) {
		return u(path.x2u(f));
	}

	@Override
	public float x() {
		return path.u2x(u);
	}

	@Override
	public HVertex y(float f) {
		return v(path.y2v(f));
	}

	@Override
	public float y() {
		return path.v2y(v);
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
		u = f;
		return this;
	}

	public float u() {
		return u;
	}

	public HVertex v(float f) {
		v = f;
		return this;
	}

	public float v() {
		return v;
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
		return cu1(path.x2u(f));
	}

	public float cx1() {
		return path.u2x(cu1);
	}

	public HVertex cy1(float f) {
		return cv1(path.y2v(f));
	}

	public float cy1() {
		return path.v2y(cv1);
	}

	public HVertex cu1(float f) {
		cu1 = f;
		return this;
	}

	public float cu1() {
		return cu1;
	}

	public HVertex cv1(float f) {
		cv1 = f;
		return this;
	}

	public float cv1() {
		return cv1;
	}

	public HVertex cx2(float f) {
		return cu2(path.x2u(f));
	}

	public float cx2() {
		return path.u2x(cu2);
	}

	public HVertex cy2(float f) {
		return cv2(path.y2v(f));
	}

	public float cy2() {
		return path.v2y(cv2);
	}

	public HVertex cu2(float f) {
		cu2 = f;
		return this;
	}

	public float cu2() {
		return cu2;
	}

	public HVertex cv2(float f) {
		cv2 = f;
		return this;
	}

	public float cv2() {
		return cv2;
	}

	public void computeMinMax(float[] minmax) {
		if(u < minmax[0]) minmax[0] = u;
		else if(u > minmax[2]) minmax[2] = u;

		if(v < minmax[1]) minmax[1] = v;
		else if(v > minmax[3]) minmax[3] = v;

		switch(numControlPts) {
		case 2:
			if(cu2 < minmax[0]) minmax[0] = cu2;
			else if(cu2 > minmax[2]) minmax[2] = cu2;

			if(cv2 < minmax[1]) minmax[1] = cv2;
			else if(cv2 > minmax[3]) minmax[3] = cv2;
		case 1:
			if(cu1 < minmax[0]) minmax[0] = cu1;
			else if(cu1 > minmax[2]) minmax[2] = cu1;

			if(cv1 < minmax[1]) minmax[1] = cv1;
			else if(cv1 > minmax[3]) minmax[3] = cv1;
			break;
		default: break;
		}
	}

	public void adjust(float offsetU, float offsetV, float oldW, float oldH) {
		x( oldW*(u += offsetU) ).y(oldH * (v += offsetV));

		switch(numControlPts) {
		case 2: cx2( oldW*(cu2 += offsetU) ).cy2(oldH * (cv2 += offsetV));
		case 1: cx1( oldW*(cu1 += offsetU) ).cy1(oldH * (cv1 += offsetV));
			break;
		default: break;
		}
	}

	private float dv(float pv, float t) {
		switch(numControlPts) {
		case 1: return HMath.bezierTangent(pv, cv1, v, t);
		case 2: return HMath.bezierTangent(pv, cv2, cv2, v, t);
		default: return v - pv;
		}
	}

	public boolean intersectTest(
		HVertex pprev, HVertex prev,
		float tu, float tv, boolean openPath
	) {
		// TODO use pixels with the tolerance
		float u1 = prev.u;
		float v1 = prev.v;
		float u2 = u;
		float v2 = v;

		if(isLine() || openPath) {
			return ((v1<=tv && tv<v2) || (v2<=tv && tv<v1)) &&
				tu < (u1 + (u2-u1)*(tv-v1)/(v2-v1));
		} else if(isQuadratic()) {
			boolean b = false;
			float[] params = new float[2];
			int numParams = HMath.bezierParam(v1, cv1,v2, tv, params);

			for(int i=0; i<numParams; ++i) {
				float t = params[i];
				if(0<t && t<1 && tu<HMath.bezierPoint(u1, cu1,u2, t)) {
					if(HMath.bezierTangent(v1, cv1,v2, t) == 0) continue;
					b = !b;
				} else if(t==0 && tu<u1) {
					float ptanv = prev.dv(pprev.v,1);
					if(ptanv==0) ptanv = prev.dv(pprev.v,0.9375f);
					float ntanv = HMath.bezierTangent(v1, cv1,v2, 0);
					if(ntanv==0) ntanv=HMath.bezierTangent(v1, cv1,v2, 0.0625f);
					if(ptanv<0 == ntanv<0) b = !b;
				}
			}
			return b;
		} else {
			boolean b = false;
			float[] params = new float[3];
			int numParams = HMath.bezierParam(v1, cv1, cv2,v2, tv, params);

			for(int i=0; i<numParams; ++i) {
				float t = params[i];
				if(0<t && t<1 && tu<HMath.bezierPoint(u1, cu1, cu2,u2, t)) {
					if(HMath.bezierTangent(v1, cv1, cv2, v, t) == 0) {
						float ptanv = HMath.bezierTangent(
							v1, cv1, cv2,v2, Math.max(t-0.0625f, 0));
						float ntanv = HMath.bezierTangent(
							v1, cv1, cv2,v2, Math.min(t+.0625f, 1));
						if(ptanv<0 != ntanv<0) continue;
					}
					b = !b;
				} else if(t==0 && tu<u1) {
					float ptanv = prev.dv(pprev.v,1);
					if(ptanv==0) ptanv = prev.dv(pprev.v,0.9375f);
					float ntanv = HMath.bezierTangent(v1, cv1, cv2, 0);
					if(ntanv==0) ntanv = HMath.bezierTangent(
						v1, cv1, cv2,v2, 0.0625f);
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
