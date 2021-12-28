package hype;

import processing.core.PGraphics;

public class HRect extends HDrawable {
	private float tl, tr, bl, br;

	public HRect() {}

	public HRect(float s) {
		size(s);
	}

	public HRect(float w, float h) {
		size(w,h);
	}

	public HRect(float w, float h, float roundingRadius) {
		size(w,h);
		rounding(roundingRadius);
	}

	@Override
	public HRect createCopy() {
		HRect copy = new HRect();
		copy.tl = tl;
		copy.tr = tr;
		copy.bl = bl;
		copy.br = br;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public HRect rounding(float radius) {
		tl = tr = bl = br = radius;
		return this;
	}

	public HRect rounding(
		float topleft, float topright,
		float bottomright, float bottomleft
	) {
		tl = topleft;
		tr = topright;
		br = bottomright;
		bl = bottomleft;
		return this;
	}

	public float rounding() {
		return roundingTL();
	}

	public HRect roundingTL(float radius) {
		tl = radius;
		return this;
	}

	public float roundingTL() {
		return tl;
	}

	public HRect roundingTR(float radius) {
		tr = radius;
		return this;
	}

	public float roundingTR() {
		return tr;
	}

	public HRect roundingBR(float radius) {
		br = radius;
		return this;
	}

	public float roundingBR() {
		return br;
	}

	public HRect roundingBL(float radius) {
		bl = radius;
		return this;
	}

	public float roundingBL() {
		return bl;
	}

	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float alphaPc
	) {
		applyStyle(g,alphaPc);
		g.rect(drawX,drawY, width, height, tl, tr, br, bl);
	}
}
