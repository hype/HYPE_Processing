package hype;

import processing.core.PConstants;
import processing.core.PGraphics;

public class HEllipse extends HDrawable {
	private int mode;
	private float startRad, endRad;

	public HEllipse() {
		mode = PConstants.PIE;
	}

	public HEllipse(float ellipseRadius) {
		this();
		radius(ellipseRadius);
	}

	public HEllipse(float radiusX, float radiusY) {
		this();
		radius(radiusX,radiusY);
	}

	@Override
	public HEllipse createCopy() {
		HEllipse copy = new HEllipse();
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public HEllipse radius(float r) {
		size(r*2);
		return this;
	}

	public HEllipse radius(float radiusX, float radiusY) {
		size(radiusX*2,radiusY*2);
		return this;
	}

	public HEllipse radiusX(float radiusX) {
		width(radiusX * 2);
		return this;
	}

	public float radiusX() {
		return width /2;
	}

	public HEllipse radiusY(float radiusY) {
		height(radiusY * 2);
		return this;
	}

	public float radiusY() {
		return height /2;
	}

	public boolean isCircle() {
		return width == height;
	}

	public HEllipse mode(int t) {
		mode = t;
		return this;
	}

	public float mode() {
		return mode;
	}

	public HEllipse start(float deg) {
		return startRad(deg * H.D2R);
	}

	public float start() {
		return startRad * H.R2D;
	}

	public HEllipse startRad(float rad) {
		startRad = HMath.normalizeAngleRad(rad);
		if(startRad > endRad) endRad += PConstants.TWO_PI;
		return this;
	}

	public float startRad() {
		return startRad;
	}

	public HEllipse end(float deg) {
		return endRad(deg * H.D2R);
	}

	public float end() {
		return endRad * H.R2D;
	}

	public HEllipse endRad(float rad) {
		endRad = HMath.normalizeAngleRad(rad);
		if(startRad > endRad) endRad += PConstants.TWO_PI;
		return this;
	}

	public float endRad() {
		return endRad;
	}

	@Override
	public boolean containsRel(float relX, float relY) {
		float cx = width /2;
		float cy = height /2;
		float dcx = relX - cx;
		float dcy = relY - cy;

		boolean inEllipse = ((dcx*dcx)/(cx*cx) + (dcy*dcy)/(cy*cy) <= 1);

		// If mode is closed, just check if it's in the ellipse
		if(startRad == endRad) return inEllipse;

		// Return false regardless of mode if it's not inside the ellipse
		else if(!inEllipse) return false;

		if(mode == PConstants.PIE) {
			float ptAngle = (float) Math.atan2(dcy*cx, dcx*cy);
			if(startRad > ptAngle) ptAngle += PConstants.TWO_PI;
			return (startRad <=ptAngle && ptAngle<= endRad);
		} else {
			float end = HMath.squishAngleRad(cx, cy, endRad);
			float start = HMath.squishAngleRad(cx, cy, startRad);
			float[] pt1 = HMath.ellipsePointRadArr(cx,cy, cx,cy, end);
			float[] pt2 = HMath.ellipsePointRadArr(cx,cy, cx,cy, start);
			return HMath.rightOfLine(pt1[0],pt1[1], pt2[0],pt2[1], relX,relY);
		}
	}

	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX,float drawY,float alphaPc
	) {
		applyStyle(g,alphaPc);

		drawX += width /2;
		drawY += height /2;

		if(startRad == endRad) {
			g.ellipse(drawX, drawY, width, height);
		} else {
			g.arc(drawX,drawY, width, height, startRad, endRad, mode);
		}
	}
}
