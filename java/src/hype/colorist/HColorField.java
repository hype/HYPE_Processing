package hype.colorist;

import hype.drawable.HDrawable;
import hype.util.H;
import hype.util.HColors;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PVector;

@SuppressWarnings("static-access")
public class HColorField implements HColorist {
	protected ArrayList<HColorPoint> _colorPoints;
	protected float _maxDist;
	protected boolean _appliesFill, _appliesStroke, _appliesAlpha;
	
	public HColorField() {
		this(H.app().width, H.app().height);
	}
	
	public HColorField(float xBound, float yBound) {
		this(H.app().sqrt(xBound*xBound + yBound*yBound));
	}
	
	public HColorField(float maximumDistance) {
		_colorPoints = new ArrayList<HColorField.HColorPoint>();
		_maxDist = maximumDistance;
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
		_colorPoints.add(pt);
		return this;
	}
	
	public int getColor(float x, float y, int baseColor) {
		PApplet app = H.app();
		int[] baseClrs = HColors.explode(baseColor);
		int[] maxClrs = new int[4];
		
		int initJ;
		if(_appliesAlpha) {
			initJ = 0;
		} else { // make the loop skip alpha and use baseClrs' alpha instead
			initJ = 1;
			maxClrs[0] = baseClrs[0];
		}
		
		for(int i=0; i<_colorPoints.size(); ++i) {
			HColorPoint pt = _colorPoints.get(i);
			
			int[] ptClrs = HColors.explode(pt.clr);
			
			// Get the adjusted distance between the two points.
			float distLimit = _maxDist * pt.radius;
			float dist = app.dist(x,y, pt.x,pt.y);
			if(dist > distLimit)
				dist = distLimit;
			
			// Compute the color based on the distance from the color point.
			for(int j=initJ; j<4; ++j) {
				int newClrVal = app.round(
					app.map(dist, 0,distLimit, ptClrs[j], baseClrs[j]));
				
				if(newClrVal > maxClrs[j]) 
					maxClrs[j] = newClrVal;
			}
		}
		return HColors.merge(maxClrs[0],maxClrs[1],maxClrs[2],maxClrs[3]);
	}
	
	public HColorField appliesAlpha(boolean b) {
		_appliesAlpha = b;
		return this;
	}
	
	public boolean appliesAlpha() {
		return _appliesAlpha;
	}
	
	@Override
	public HColorField fillOnly() {
		_appliesFill = true;
		_appliesStroke = false;
		return this;
	}

	@Override
	public HColorField strokeOnly() {
		_appliesFill = false;
		_appliesStroke = true;
		return this;
	}

	@Override
	public HColorField fillAndStroke() {
		_appliesFill = _appliesStroke = true;
		return this;
	}
	
	@Override
	public boolean appliesFill() {
		return _appliesFill;
	}
	
	@Override
	public boolean appliesStroke() {
		return _appliesStroke;
	}
	
	@Override
	public HDrawable applyColor(HDrawable drawable) {
		float x = drawable.x();
		float y = drawable.y();
		
		if(_appliesFill) {
			int baseFill = drawable.fill();
			drawable.fill( getColor(x,y, baseFill) );
		}
		if(_appliesStroke) {
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
