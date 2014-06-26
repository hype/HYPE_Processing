/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.extended.behavior;

import hype.core.behavior.HBehavior;
import hype.core.drawable.HDrawable;
import hype.core.util.HConstants;
import hype.core.util.HMath;
import processing.core.PApplet;
import processing.core.PImage;

public class HColorLightness extends HBehavior {

	private HDrawable _target;
	private PImage img;
	private int light_or_bright = 1;//lightness == 1, brightness == 2
	private int last_color = -16777216;//default to black
	private float lightness = 0;

	private float _min1, _min2, _min3;
	private float _rel1, _rel2, _rel3;
	private float _max1, _max2, _max3;
	private float _curr1, _curr2, _curr3;
	private float _origw, _origh;
	private int _property;

	public HColorLightness() {
		_property = HConstants.SCALE;
		register();
	}

	@Override
	public HColorLightness image(PImage imgArg) {
		img = imgArg;
		return this;
	}
	
	public HColorLightness(Object imgArg) {
		this();
		image(imgArg);
	}
	
	@Override
	public HColorLightness image(Object imgArg) {
		img = H.getImage(imgArg);
		return this;
	}

	@Override
	public PImage image() {
		return img;
	}

	public HColorLightness useLightness() {
		light_or_bright = 1;
		return this;
	}

	public HColorLightness useBrightness() {
		light_or_bright = 2;
		return this;
	}

	public boolean usesLightness() {
		return (light_or_bright == 1) ? true : false;
	}

	public boolean usesBrightness() {
		return (light_or_bright == 2) ? true : false;
	}
	
	public HColorLightness target(HDrawable d) {
		_target = d;
		if(d != null) {
			_origw = d.width();
			_origh = d.height();
		}
		return this;
	}
	
	public HDrawable target() {
		return _target;
	}
		
	public HColorLightness range(float minimum, float maximum) {
		return min(minimum).max(maximum);
	}
	
	public HColorLightness range(
		float minA, float minB,
		float maxA, float maxB
	) {
		return min(minA,minB).max(maxA,maxB);
	}
	
	public HColorLightness range(
		float minA, float minB, float minC,
		float maxA, float maxB, float maxC
	) {
		return min(minA,minB,minC).max(maxA,maxB,maxC);
	}
	
	public HColorLightness min(float a) {
		return min(a,a);
	}
	
	public HColorLightness min(float a, float b) {
		return min(a,b,0);
	}
	
	public HColorLightness min(float a, float b, float c) {
		_min1 = a;
		_min2 = b;
		_min3 = c;
		return this;
	}
	
	public float min() {
		return _min1;
	}
	
	public float min1() {
		return _min1;
	}
	
	public float min2() {
		return _min2;
	}
	
	public float min3() {
		return _min3;
	}
	
	public HColorLightness relativeVal(float a) {
		return relativeVal(a,a);
	}
	
	public HColorLightness relativeVal(float a, float b) {
		return relativeVal(a,b,0);
	}
	
	public HColorLightness relativeVal(float a, float b, float c) {
		_rel1 = a;
		_rel2 = b;
		_rel3 = c;
		return this;
	}
	
	public float relativeVal() {
		return _rel1;
	}
	
	public float relativeVal1() {
		return _rel1;
	}
	
	public float relativeVal2() {
		return _rel2;
	}
	
	public float relativeVal3() {
		return _rel3;
	}
	
	public HColorLightness max(float a) {
		return max(a,a);
	}
	
	public HColorLightness max(float a, float b) {
		return max(a,b,0);
	}
	
	public HColorLightness max(float a, float b, float c) {
		_max1 = a;
		_max2 = b;
		_max3 = c;
		return this;
	}
	
	public float max() {
		return _max1;
	}
	
	public float max1() {
		return _max1;
	}
	
	public float max2() {
		return _max2;
	}
	
	public float max3() {
		return _max3;
	}
	
	public HColorLightness property(int id) {
		_property = id;
		return this;
	}
	
	public int property() {
		return _property;
	}

	private int getColor(float x, float y) {
		return (img==null) ? 0 : img.get(Math.round(x), Math.round(y));
	}

	private float getLightness(int c) {

		float r = (c >> 16 & 0xff);
		float g = (c >> 8 & 0xff);
		float b = (c & 0xff);

		float min = Math.min(r, g);
		min = Math.min(min, b);

		float max = Math.max(r, g);
		max = Math.max(max, b);

		return ( max + min ) / 2;
	}

	private float getBrightness(int c) {

		float r = (c >> 16 & 0xff);
		float g = (c >> 8 & 0xff);
		float b = (c & 0xff);

		float max = Math.max(r, g);
		max = Math.max(max, b);

		return max;
	}
	
	public float nextRaw() {

		int c = getColor(_target.x(), _target.y());

		if (c != last_color) {
			last_color = c;

			if (usesLightness()) {
				lightness = getLightness(c);
			} else {
				lightness = getBrightness(c);
			}
		}
		
		_curr1 = HMath.map(lightness, 0,255, _min1,_max1) + _rel1;
		_curr2 = HMath.map(lightness, 0,255, _min2,_max2) + _rel2;
		_curr3 = HMath.map(lightness, 0,255, _min3,_max3) + _rel3;
		
		return lightness;
	}
	
	public float curr() {
		return _curr1;
	}
	
	public float curr1() {
		return _curr1;
	}
	
	public float curr2() {
		return _curr2;
	}
	
	public float curr3() {
		return _curr3;
	}
	
	@Override
	public void runBehavior(PApplet app) {
		if(_target==null) return;
		
		nextRaw();
		float v1 = _curr1;
		float v2 = _curr2;
		float v3 = _curr3;
		
		switch(_property) {
		case HConstants.WIDTH:		_target.width(v1); break;
		case HConstants.HEIGHT:		_target.height(v1); break;
		case HConstants.SCALE:
			v1 *= _origw;
			v2 *= _origh;
		case HConstants.SIZE:		_target.size(v1,v2); break;
		case HConstants.ALPHA:		_target.alpha(Math.round(v1)); break;
		case HConstants.X:			_target.x(v1); break;
		case HConstants.Y:			_target.y(v1); break;
		case HConstants.Z:			_target.z(v1); break;
		case HConstants.LOCATION:	_target.loc(v1,v2,v3); break;
		case HConstants.ROTATIONX:	_target.rotationX(v1); break;
		case HConstants.ROTATIONY:	_target.rotationY(v1); break;
		case HConstants.ROTATIONZ:	_target.rotationZ(v1); break;
		case HConstants.DROTATIONX:	_target.rotateX(v1); break;
		case HConstants.DROTATIONY:	_target.rotateY(v1); break;
		case HConstants.DROTATIONZ:	_target.rotateZ(v1); break;
		case HConstants.DX:			_target.move(v1,0); break;
		case HConstants.DY:			_target.move(0,v1); break;
		case HConstants.DLOC:		_target.move(v1,v1); break;
		default: break;
		}
	}
	
	@Override
	public HColorLightness register() {
		return (HColorLightness) super.register();
	}
	
	@Override
	public HColorLightness unregister() {
		return (HColorLightness) super.unregister();
	}
}
