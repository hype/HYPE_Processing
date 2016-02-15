package hype.extended.layout;

import hype.H;
import hype.interfaces.HLayout;
import hype.HDrawable;
import processing.core.PVector;

public class HShapeLayout implements HLayout {
	private HDrawable target;
	private float[] bounds;
	private int iterationLimit;

	public HShapeLayout() {
		iterationLimit = 1024;
		bounds = new float[4];
	}

	public HShapeLayout iterationLimit(int i) {
		iterationLimit = i;
		return this;
	}

	public int iterationLimit() {
		return iterationLimit;
	}

	public HShapeLayout target(HDrawable d) {
		target = d;
		if(target != null) target.bounds(bounds);
		return this;
	}

	public HDrawable target() {
		return target;
	}

	@Override
	public void applyTo(HDrawable target) {
		PVector pt = getNextPoint();
		if(pt != null) target.loc(pt);
	}

	@Override
	public PVector getNextPoint() {
		if(target == null) return null;

//		float[] loc = HMath.absLocArr(target,0,0);
//		float x1 = loc[0] - target.anchorX();
//		float y1 = loc[1] - target.anchorY();
//		float x2 = x1 + target.width();
//		float y2 = y1 + target.height();
		float x1 = bounds[0];
		float y1 = bounds[1];
		float x2 = bounds[0] + bounds[2];
		float y2 = bounds[1] + bounds[3];

		for(int i=0; i< iterationLimit; ++i) {
			float x = H.app().random(x1,x2);
			float y = H.app().random(y1,y2);
			if(target.contains(x,y))
				return new PVector(x,y);
		}
		return null;
	}
}
