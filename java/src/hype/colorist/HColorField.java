package hype.colorist;

import hype.drawable.HDrawable;
import hype.util.H;
import hype.util.HColorUtil;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PVector;

@SuppressWarnings("static-access")
public class HColorField implements HColorist {
	protected ArrayList<HColorPoint> colorPoints;
	protected float maxDist;
	protected boolean fillFlag, strokeFlag;
	
	public HColorField() {
		this(H.app().width, H.app().height);
	}
	
	public HColorField(float xBound, float yBound) {
		this(H.app().sqrt(xBound*xBound + yBound*yBound));
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
		PApplet app = H.app();
		int[] baseClrs = HColorUtil.explode(baseColor);
		int[] maxClrs = new int[4];
		
		for(int i=0; i<colorPoints.size(); i++) {
			HColorPoint pt = colorPoints.get(i);
			
			int[] ptClrs = HColorUtil.explode(pt.clr);
			
			float distLimit = maxDist * pt.radius;
			float dist = app.dist(x,y, pt.x,pt.y);
			if(dist > distLimit)
				dist = distLimit;
			
			for(int j=0; j<4; j++) {
				int newClrVal = app.round(
					app.map(dist, 0,distLimit, ptClrs[j], baseClrs[j]));
				if(newClrVal > maxClrs[j])
					maxClrs[j] = newClrVal;
			}
		}
		return HColorUtil.merge(maxClrs[0],maxClrs[1],maxClrs[2],maxClrs[3]);
	}

	@Override
	public HColorField fillOnly() {
		fillFlag = true;
		strokeFlag = false;
		return this;
	}

	@Override
	public HColorField strokeOnly() {
		fillFlag = false;
		strokeFlag = true;
		return this;
	}

	@Override
	public HColorField fillAndStroke() {
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
		float x = drawable.x();
		float y = drawable.y();
		
		if(fillFlag) {
			int baseFill = drawable.fill();
			drawable.fill( getColor(x,y, baseFill) );
		}
		if(strokeFlag) {
			int baseStroke = drawable.stroke();
			drawable.stroke( getColor(x,y, baseStroke) );
		}
		return drawable;
	}
	
	public static class HColorPoint {
		float x, y, radius;
		int clr;
	}
}
