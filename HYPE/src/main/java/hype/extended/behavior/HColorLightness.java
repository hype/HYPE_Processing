package hype.extended.behavior;

import hype.H;
import hype.HBehavior;
import hype.HDrawable;
import hype.HDrawable3D;
import hype.interfaces.HConstants;
import hype.HMath;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;

public class HColorLightness extends HBehavior {

	private HDrawable target;
	private PImage img;
	private int light_or_bright = 1;//lightness == 1, brightness == 2
	private int last_color = -16777216;//default to black
	private float lightness = 0;

	private float min1, min2, min3;
	private float rel1, rel2, rel3;
	private float max1, max2, max3;
	private float curr1, curr2, curr3;
	private float origw, origh, origd;
	private int property;

	public HColorLightness() {
		property = HConstants.SCALE;
		register();
	}

	public HColorLightness(Object imgArg) {
		this();
		image(imgArg);
	}
	
	public HColorLightness image(Object imgArg) {
		img = H.getImage(imgArg);
		return this;
	}

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
		target = d;
		if(d != null) {
			origw = d.width();
			origh = d.height();
			origd = 0;
		}
		return this;
	}

	public HColorLightness target(HDrawable3D d) {
		target = d;
		if(d != null) {
			origw = d.width();
			origh = d.height();
			origd = d.depth();
		}
		return this;
	}
	
	public HDrawable target() {
		return target;
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
		min1 = a;
		min2 = b;
		min3 = c;
		return this;
	}
	
	public float min() {
		return min1;
	}
	
	public float min1() {
		return min1;
	}
	
	public float min2() {
		return min2;
	}
	
	public float min3() {
		return min3;
	}
	
	public HColorLightness relativeVal(float a) {
		return relativeVal(a,a);
	}
	
	public HColorLightness relativeVal(float a, float b) {
		return relativeVal(a,b,0);
	}
	
	public HColorLightness relativeVal(float a, float b, float c) {
		rel1 = a;
		rel2 = b;
		rel3 = c;
		return this;
	}
	
	public float relativeVal() {
		return rel1;
	}
	
	public float relativeVal1() {
		return rel1;
	}
	
	public float relativeVal2() {
		return rel2;
	}
	
	public float relativeVal3() {
		return rel3;
	}
	
	public HColorLightness max(float a) {
		return max(a,a);
	}
	
	public HColorLightness max(float a, float b) {
		return max(a,b,0);
	}
	
	public HColorLightness max(float a, float b, float c) {
		max1 = a;
		max2 = b;
		max3 = c;
		return this;
	}
	
	public float max() {
		return max1;
	}
	
	public float max1() {
		return max1;
	}
	
	public float max2() {
		return max2;
	}
	
	public float max3() {
		return max3;
	}
	
	public HColorLightness property(int id) {
		property = id;
		return this;
	}
	
	public int property() {
		return property;
	}

	private int getColor(float x, float y) {
		return (img == null) ? 0 : img.get(Math.round(x), Math.round(y));
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

		int c = getColor(target.x(), target.y());

		if (c != last_color) {
			last_color = c;

			if (usesLightness()) {
				lightness = getLightness(c);
			} else {
				lightness = getBrightness(c);
			}
		}
		
		curr1 = HMath.map(lightness, 0,255, min1,max1) + rel1;
		curr2 = HMath.map(lightness, 0,255, min2,max2) + rel2;
		curr3 = HMath.map(lightness, 0,255, min3,max3) + rel3;
		
		return lightness;
	}
	
	public float curr() {
		return curr1;
	}
	
	public float curr1() {
		return curr1;
	}
	
	public float curr2() {
		return curr2;
	}
	
	public float curr3() {
		return curr3;
	}
	
	@Override
	public void runBehavior(PApplet app) {
		if(target == null) return;
		
		nextRaw();
		float v1 = curr1;
		float v2 = curr2;
		float v3 = curr3;
		
		switch(property) {
		case HConstants.WIDTH:		target.width(v1); break;
		case HConstants.HEIGHT:		target.height(v1); break;
		case HConstants.SCALE:
			v1 *= origw;
			v2 *= origh;
			v3 *= origd;
		case HConstants.SIZE:		target.size(new PVector(v1, v2, v3)); break;
		case HConstants.ALPHA:		target.alpha(Math.round(v1)); break;
		case HConstants.X:			target.x(v1); break;
		case HConstants.Y:			target.y(v1); break;
		case HConstants.Z:			target.z(v1); break;
		case HConstants.LOCATION:	target.loc(v1, v2, v3); break;
		case HConstants.ROTATIONX:	target.rotationX(v1); break;
		case HConstants.ROTATIONY:	target.rotationY(v1); break;
		case HConstants.ROTATIONZ:	target.rotationZ(v1); break;
		case HConstants.DROTATIONX:	target.rotateX(v1); break;
		case HConstants.DROTATIONY:	target.rotateY(v1); break;
		case HConstants.DROTATIONZ:	target.rotateZ(v1); break;
		case HConstants.DX:			target.move(v1, 0); break;
		case HConstants.DY:			target.move(0, v1); break;
		case HConstants.DLOC:		target.move(v1, v1); break;
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
