package hype.extended.colorist;

import hype.H;
import hype.interfaces.HColorist;
import hype.HDrawable;
import hype.HColors;
import hype.HMath;
import processing.core.PVector;

import java.util.ArrayList;

public class HColorField implements HColorist {
	private ArrayList<HColorPoint> colorPoints;
	private float maxDist;
	private boolean appliesFill, appliesStroke, appliesAlpha;

	public HColorField() {
		this(H.app().width, H.app().height);
	}

	public HColorField(float xBound, float yBound) {
		this( (float) Math.sqrt(xBound*xBound + yBound*yBound) );
	}

	public HColorField(float maximumDistance) {
		colorPoints = new ArrayList<HColorField.HColorPoint>();
		maxDist = maximumDistance;
		fillAndStroke();
	}

	public HColorField addPoint(PVector loc, int clr, float radius) {
		return addPoint(loc.x,loc.y, clr, radius);
	}

	public HColorField addPoint(float x, float y, int clr, float radius) {
		HColorPoint pt = new HColorPoint();
		pt.x = x;
		pt.y = y;
		pt.radius = radius;
		pt.clr = clr;
		colorPoints.add(pt);
		return this;
	}

	public int getColor(float x, float y, int baseColor) {
		int[] baseClrs = HColors.explode(baseColor);
		int[] maxClrs = new int[4];

		int initJ;
		if(appliesAlpha) {
			initJ = 0;
		} else { // make the loop skip alpha and use baseClrs' alpha instead
			initJ = 1;
			maxClrs[0] = baseClrs[0];
		}

		for(int i=0; i< colorPoints.size(); ++i) {
			HColorPoint pt = colorPoints.get(i);

			int[] ptClrs = HColors.explode(pt.clr);

			// Get the adjusted distance between the two points.
			float distLimit = maxDist * pt.radius;
			float dist = HMath.dist(x,y, pt.x,pt.y);
			if(dist > distLimit)
				dist = distLimit;

			// Compute the color based on the distance from the color point.
			for(int j=initJ; j<4; ++j) {
				int newClrVal = Math.round(
					HMath.map(dist, 0,distLimit, ptClrs[j], baseClrs[j]));

				if(newClrVal > maxClrs[j])
					maxClrs[j] = newClrVal;
			}
		}
		return HColors.merge(maxClrs[0],maxClrs[1],maxClrs[2],maxClrs[3]);
	}

	public HColorField appliesAlpha(boolean b) {
		appliesAlpha = b;
		return this;
	}

	public boolean appliesAlpha() {
		return appliesAlpha;
	}

	@Override
	public HColorField fillOnly() {
		appliesFill = true;
		appliesStroke = false;
		return this;
	}

	@Override
	public HColorField strokeOnly() {
		appliesFill = false;
		appliesStroke = true;
		return this;
	}

	@Override
	public HColorField fillAndStroke() {
		appliesFill = appliesStroke = true;
		return this;
	}

	@Override
	public boolean appliesFill() {
		return appliesFill;
	}

	@Override
	public boolean appliesStroke() {
		return appliesStroke;
	}

	@Override
	public HDrawable applyColor(HDrawable drawable) {
		float x = drawable.x();
		float y = drawable.y();

		if(appliesFill) {
			int baseFill = drawable.fill();
			drawable.fill( getColor(x,y, baseFill) );
		}
		if(appliesStroke) {
			int baseStroke = drawable.stroke();
			drawable.stroke( getColor(x,y, baseStroke) );
		}
		return drawable;
	}



	public static class HColorPoint {
		public float x, y, radius;
		public int clr;
	}
}
