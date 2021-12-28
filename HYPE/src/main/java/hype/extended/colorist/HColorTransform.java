package hype.extended.colorist;

import hype.HColors;
import hype.interfaces.HColorist;
import hype.HDrawable;

public class HColorTransform implements HColorist {
	private float percA, percR, percG, percB;
	private int offsetA, offsetR, offsetG, offsetB;
	private boolean fillFlag, strokeFlag;

	public HColorTransform() {
		percA = percR = percG = percB = 1;
		fillAndStroke();
	}

	public HColorTransform offset(int off) {
		offsetA = offsetR = offsetG = offsetB = off;
		return this;
	}

	public HColorTransform offset(int r, int g, int b, int a) {
		offsetA = a;
		offsetR = r;
		offsetG = g;
		offsetB = b;
		return this;
	}

	public HColorTransform offsetA(int a) {
		offsetA = a;
		return this;
	}

	public int offsetA() {
		return offsetA;
	}

	public HColorTransform offsetR(int r) {
		offsetR = r;
		return this;
	}

	public int offsetR() {
		return offsetR;
	}

	public HColorTransform offsetG(int g) {
		offsetG = g;
		return this;
	}

	public int offsetG() {
		return offsetG;
	}

	public HColorTransform offsetB(int b) {
		offsetB = b;
		return this;
	}

	public int offsetB() {
		return offsetB;
	}

	public HColorTransform perc(float percentage) {
		percA = percR = percG = percB = percentage;
		return this;
	}

	public HColorTransform perc(int r, int g, int b, int a) {
		percA = a;
		percR = r;
		percG = g;
		percB = b;
		return this;
	}

	public HColorTransform percA(float a) {
		percA = a;
		return this;
	}

	public float percA() {
		return percA;
	}

	public HColorTransform percR(float r) {
		percR = r;
		return this;
	}

	public float percR() {
		return percR;
	}

	public HColorTransform percG(float g) {
		percG = g;
		return this;
	}

	public float percG() {
		return percG;
	}

	public HColorTransform percB(float b) {
		percB = b;
		return this;
	}

	public float percB() {
		return percB;
	}

	public HColorTransform mergeWith(HColorTransform other) {
		if(other != null) {
			percA *= other.percA;
			percR *= other.percR;
			percG *= other.percG;
			percB *= other.percB;
			offsetA += other.offsetA;
			offsetR += other.offsetR;
			offsetG += other.offsetG;
			offsetB += other.offsetB;
		}
		return this;
	}

	public HColorTransform createCopy() {
		HColorTransform copy = new HColorTransform();
		copy.percA = percA;
		copy.percR = percR;
		copy.percG = percG;
		copy.percB = percB;
		copy.offsetA = offsetA;
		copy.offsetR = offsetR;
		copy.offsetG = offsetG;
		copy.offsetB = offsetB;
		return copy;
	}

	public HColorTransform createNew(HColorTransform other) {
		return createCopy().mergeWith(other);
	}

	public int getColor(int origColor) {
		int[] clrs = HColors.explode(origColor);
		clrs[0] = Math.round(clrs[0] * percA) + offsetA;
		clrs[1] = Math.round(clrs[1] * percR) + offsetR;
		clrs[2] = Math.round(clrs[2] * percG) + offsetG;
		clrs[3] = Math.round(clrs[3] * percB) + offsetB;
		return HColors.merge(clrs[0],clrs[1],clrs[2],clrs[3]);
	}

	@Override
	public HColorTransform fillOnly() {
		fillFlag = true;
		strokeFlag = false;
		return this;
	}

	@Override
	public HColorTransform strokeOnly() {
		fillFlag = false;
		strokeFlag = true;
		return this;
	}

	@Override
	public HColorTransform fillAndStroke() {
		fillFlag = strokeFlag = true;
		return this;
	}

	@Override
	public boolean appliesFill() {
		return fillFlag;
	}

	@Override
	public boolean appliesStroke() {
		return strokeFlag;
	}

	@Override
	public HDrawable applyColor(HDrawable drawable) {
		if(fillFlag) {
			int fill = drawable.fill();
			drawable.fill( getColor(fill) );
		}
		if(strokeFlag) {
			int stroke = drawable.stroke();
			drawable.stroke( getColor(stroke) );
		}
		return drawable;
	}
}
